"""Regression tests for configured root-document generation and relative links."""
import contextlib
import io
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO / "scripts"))
import sync_readme as sr  # noqa: E402

LANGS = ("en", "ko", "es", "vi", "ar", "fr")

SOURCE = """# Title

[![English](https://example.com/en.svg)](README.en.md)
[![한국어](https://example.com/ko.svg)](README.ko.md "Korean")
[License](../LICENSE) | [Anchor](#install) | [Site](https://example.com/a/../b) | [Mail](mailto:a@b.c)
[Abs](/already/root.md) | [Guide](release-guidelines/release-guidelines.{lang}.md#top) | [Dir](assets/)
<img src="assets/logo.png"> and `[code](README.en.md)`

```
[fenced](README.en.md)
```

[ref]: ../.github/MAINTENANCE.md
"""


def make_repo(default_language="en"):
    """A throwaway repository with sources whose first line names their language."""
    root = Path(tempfile.mkdtemp())
    (root / "docs/release-guidelines").mkdir(parents=True)
    (root / "docs/contributing").mkdir(parents=True)
    (root / "docs/security").mkdir(parents=True)
    languages = {lang: f"docs/README.{lang}.md" for lang in LANGS}
    guides = {lang: f"docs/release-guidelines/release-guidelines.{lang}.md" for lang in LANGS}
    contributions = {lang: f"docs/contributing/CONTRIBUTING.{lang}.md" for lang in LANGS}
    security = {lang: f"docs/security/SECURITY.{lang}.md" for lang in LANGS}
    config = [f"default_language: {default_language}", "languages:"]
    config += [f"  {lang}: {path}" for lang, path in languages.items()]
    config += ["release_guidelines:"] + [f"  {lang}: {path}" for lang, path in guides.items()]
    for group, paths in (("contributing", contributions), ("security", security)):
        config += [f"{group}:"] + [f"  {lang}: {path}" for lang, path in paths.items()]
    (root / "docs/config.yml").write_text("\n".join(config) + "\n", encoding="utf-8")
    for lang in LANGS:
        (root / languages[lang]).write_text(f"LANG={lang}\n" + SOURCE.format(lang=lang), encoding="utf-8")
        (root / guides[lang]).write_text(f"GUIDE={lang}\n[Back](../README.{lang}.md)\n", encoding="utf-8")
        (root / contributions[lang]).write_text(
            f"CONTRIBUTING={lang}\n[Security](../security/SECURITY.{lang}.md)\n"
            "[Maintenance](../../.github/MAINTENANCE.md)\n", encoding="utf-8")
        (root / security[lang]).write_text(
            f"SECURITY={lang}\n[Tools](../../tools)\n[Workflows](../../.github/workflows)\n"
            f"[English](SECURITY.en.md)\n[Supported casks](../README.{lang}.md)\n", encoding="utf-8")
    return root


class RebaseTest(unittest.TestCase):
    def test_relative_targets_move_to_the_new_folder(self):
        self.assertEqual(sr.rebase_target("README.ko.md", "docs"), "docs/README.ko.md")
        self.assertEqual(sr.rebase_target("../LICENSE", "docs"), "LICENSE")
        self.assertEqual(sr.rebase_target("../.github/MAINTENANCE.md", "docs"), ".github/MAINTENANCE.md")
        self.assertEqual(sr.rebase_target("./x/../a.md#frag", "docs/g"), "docs/g/a.md#frag")
        self.assertEqual(sr.rebase_target("assets/", "docs"), "docs/assets/")
        self.assertEqual(sr.rebase_target("<a b.md>", "docs"), "<docs/a b.md>")
        self.assertEqual(sr.rebase_target("../../README.en.md", "docs/g"), "README.en.md")

    def test_absolute_and_anchor_targets_are_untouched(self):
        for target in ("https://example.com/a", "mailto:a@b.c", "#install", "/root.md", "//cdn/x.png", ""):
            self.assertEqual(sr.rebase_target(target, "docs"), target)

    def test_same_folder_is_a_no_op(self):
        self.assertEqual(sr.rebase_target("./a.md", "docs", "docs"), "./a.md")

    def test_markdown_html_and_reference_links(self):
        out = sr.rebase_links(SOURCE.format(lang="en"), "docs")
        self.assertIn("](docs/README.en.md)", out)
        self.assertIn('](docs/README.ko.md "Korean")', out)
        self.assertIn("[License](LICENSE)", out)
        self.assertIn("[Anchor](#install)", out)
        self.assertIn("[Site](https://example.com/a/../b)", out)
        self.assertIn("[Mail](mailto:a@b.c)", out)
        self.assertIn("[Abs](/already/root.md)", out)
        self.assertIn("[Guide](docs/release-guidelines/release-guidelines.en.md#top)", out)
        self.assertIn("[Dir](docs/assets/)", out)
        self.assertIn('<img src="docs/assets/logo.png">', out)
        self.assertIn("`[code](README.en.md)`", out)
        self.assertIn("[fenced](README.en.md)", out)
        self.assertIn("[ref]: .github/MAINTENANCE.md", out)


class SyncTest(unittest.TestCase):
    def repo(self, default_language="en"):
        root = make_repo(default_language)
        self.addCleanup(shutil.rmtree, root)
        return root

    def run_main(self, root, *extra):
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            return sr.main(["--root", str(root), *extra])

    def test_default_language_english(self):
        root = self.repo("en")
        self.assertEqual(self.run_main(root), 0)
        self.assertTrue((root / "README.md").read_text().startswith("LANG=en\n"))
        self.assertTrue((root / "release-guidelines.md").read_text().startswith("GUIDE=en\n"))
        self.assertTrue((root / ".github/CONTRIBUTING.md").read_text().startswith("CONTRIBUTING=en\n"))
        self.assertTrue((root / ".github/SECURITY.md").read_text().startswith("SECURITY=en\n"))

    def test_default_language_korean_selects_korean_sources(self):
        root = self.repo("ko")
        self.assertEqual(self.run_main(root), 0)
        readme = (root / "README.md").read_text()
        self.assertTrue(readme.startswith("LANG=ko\n"))
        self.assertIn("](docs/README.en.md)", readme)
        guide = (root / "release-guidelines.md").read_text()
        self.assertTrue(guide.startswith("GUIDE=ko\n"))
        self.assertIn("[Back](docs/README.ko.md)", guide)

    def test_community_links_stay_on_the_viewed_repository_and_branch(self):
        root = self.repo("ko")
        self.assertEqual(self.run_main(root), 0)
        contribution = (root / ".github/CONTRIBUTING.md").read_text()
        self.assertTrue(contribution.startswith("CONTRIBUTING=ko\n"))
        base = "/"
        self.assertIn(f"[Security]({base}docs/security/SECURITY.ko.md)", contribution)
        self.assertIn(f"[Maintenance]({base}.github/MAINTENANCE.md)", contribution)
        policy = (root / ".github/SECURITY.md").read_text()
        self.assertTrue(policy.startswith("SECURITY=ko\n"))
        self.assertIn(f"[Tools]({base}tools)", policy)
        self.assertIn(f"[Workflows]({base}.github/workflows)", policy)
        self.assertIn(f"[English]({base}docs/security/SECURITY.en.md)", policy)
        self.assertIn(f"[Supported casks]({base}docs/README.ko.md)", policy)

    def test_github_output_reports_changed_then_noop(self):
        root = self.repo("en")
        output = root / "gh-output"
        self.assertEqual(self.run_main(root, "--github-output", str(output)), 0)
        self.assertIn("changed=true\n", output.read_text())
        output.write_text("")
        self.assertEqual(self.run_main(root, "--github-output", str(output)), 0)
        self.assertEqual(output.read_text(), "changed=false\nfiles=\n")

    def test_sync_real_repository(self):
        # The checked in documentation must be completely in sync with scripts/sync_readme.py.
        config = sr.load_config(REPO)
        for group, target in sr.ENTRIES.items():
            rendered = sr.render_entry(REPO, config, group)
            self.assertEqual((REPO / target).read_text(encoding="utf-8"), rendered, f"{target} is out of date")


if __name__ == "__main__":
    unittest.main()
