# egovframe-chocolatey project context

Observed from the `work` source at `9fd03af8d8443087247f06c55e34d5126e3725b5` on 2026-10-26.
This is a maintenance context card, not a claim that application checks were run during adoption.

## Role and public entry points

Chocolatey package source for the eGovFrame Windows development environment. Entry points are `egovframe.nuspec`, PowerShell install/before-modify/uninstall scripts in `tools/`, localized docs and Windows CI. This is packaging, not the underlying Eclipse/eGovFrame implementation.

## Evidence and maintenance boundaries

- `README.md`: installation layout, workspace preservation, bundled Java and package maintenance.
- `tools/chocolateyinstall.ps1`, `tools/chocolateyuninstall.ps1`: official URL/checksum, staging and managed-versus-user directory behavior.
- `docs/contributing/CONTRIBUTING.en.md`: local package install check and source-doc sync.
- `.github/workflows/test.yml`: Windows pack/install/reinstall/uninstall checks and bundled-Java Eclipse smoke; deployment is a separate manual input.
- `.github/workflows/sync-readme.yml`, `docs/config.yml`: localized generated entrypoints.
- `.github/workflows/malware-scan.yml`: separate scanner workflow, not executed during adoption. No root AGENTS or CodeGraph index was present.

Keep the change scope and workflow policy in the [constitution](constitution.md); concept cards
link there rather than repeating the policy. Author a concept card only for actual planned work.

## Build and verification commands

- On a disposable Windows test host, contribution docs use `choco pack` and `choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y`; test.yml records the full reinstall/uninstall/workspace-retention sequence. These mutate the test host and were not run on this Mac.
- Documentation: `uv run --with PyYAML==6.0.3 scripts/sync_readme.py` after localized source changes.
- Documentation unit tests: `uv run --with PyYAML==6.0.3 python -m unittest discover -s tests -v`; these do not verify the Windows installer.
- Do not trigger manual deployment or scanner jobs merely to verify Spec Kit adoption. No package/install/malware success is claimed here.

For this tooling-only adoption, verify Spec Kit CLI/integration status, installed core/bug commands,
constitution completeness, and template resolution/scaffold presence. Full application build,
lint, tests, formatter, external services, and deployment are not part of that smoke check.

## Upstream and submission baseline

Remote metadata confirms an owner source repository with no actual upstream and current default work. Do not invent an external upstream or change that default. The verified pre-adoption default SHA is the recorded reference; owner release policy remains in the existing docs/workflow.

Future owner-repository changes follow the verified base and existing release policy in a separate clean Orca worktree. Keep Spec Kit/card/report commits on work and transfer only intended packaging/test/user-doc changes to any release or submission branch. There is no external upstream-submit branch to fabricate, and no publication is authorized by adoption.
No PR is created by adoption. Do not merge `work` or cherry-pick its adoption commit into a submission.
Preserve existing submission branches and PRs. Inspect changed paths and commits against the exact
base before any later PR; exclude work-only scaffolding without deleting upstream-owned files.

## Working with the pinned tooling

Installed by `uvx --from specify-cli==1.2.3 specify init --here --force --non-interactive
--integration omp --script sh --extension bug` after checking for existing path conflicts.
The CLI's init metadata pins 1.2.3; native agent commands live in `.omp/commands/`, including
`speckit.bug.assess.md`, `speckit.bug.fix.md`, and `speckit.bug.test.md`.
Use official upgrade support for future changes and preserve local customizations.
The new [domain model card template](../templates/model-card-template.md) aligns concept meanings
before specification; it is not an ML performance or benchmark card.

Observed submission base: `9fd03af8d8443087247f06c55e34d5126e3725b5` (leejongyoung/egovframe-chocolatey, `work`).
Submission branch status: not-applicable-no-upstream; verified own default base preserved.
