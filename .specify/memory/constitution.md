# egovframe-chocolatey Constitution

## Core Principles

### I. Preserve the public contract

Preserve package identity, official download/version/checksum linkage, installation layout and user-workspace retention. README and tools scripts establish that workspace-egov survives reinstall/upgrade and uninstall, while eclipse/notice are managed program files. Never treat user projects as replaceable package contents.
Compatibility changes MUST identify affected consumers, document migration needs, and be reviewed
explicitly. Existing behavior and published contracts take precedence over an agent's inference.

### II. Evidence before implementation

Before changing a concept, write its domain card in `.specify/model-cards/` using
[the model card template](../templates/model-card-template.md). Separate published contracts,
observed behavior, public issue claims, and unverified hypotheses. Use synthetic examples only.
Unresolved product policy MUST remain an open question; a small bug fix MUST preserve the established
contract rather than silently invent a new policy. Record a short design decision only when a real
choice needs explanation.

### III. Scoped, reviewable changes

Each change MUST address one evidenced problem. Preserve unrelated user work and existing project
customizations; do not bundle application fixes, dependency upgrades, formatting, and tooling adoption.
Keep installer behavior, package release/version work and generated documentation changes separate. This adoption neither installs a package nor publishes a Chocolatey release.
Check existing fork/upstream issues and open PRs before implementing a proposed contribution.

### IV. Verify what is claimed

Choose verification from the actual commands and environmental limits in the
[project card](project-card.md). Application changes MUST have targeted checks and appropriate
regression coverage where the repository provides a test path; new checks must exercise behavior,
not merely repeat implementation. Record the exact command, outcome, and omitted checks with reasons.
A scaffold smoke check, static inspection, or unavailable service MUST NOT be reported as application,
integration, deployment, or end-to-end success. Do not invent a passing CI result.

### V. Protect data and submission boundaries

Commit no secrets, credentials, session state, personal records, or machine-specific configuration.
Keep SHA-256 download verification and staging cleanup. CHOCOLATEY_API_KEY belongs only in configured secret storage and must not appear in cards, commands or reports. Malware-scan evidence and a successful installer smoke are different claims; do not infer one from the other.
Native OMP commands are installed in `.omp/commands/`; do not add model, authentication, provider,
or billing settings. Keep `.specify/`, Spec Kit command/skill files, cards, plans, and operational
reports on `work`. These artifacts MUST NOT enter upstream submission commits or PRs. Preserve any
same-named files already present in the actual upstream base.

## Project Constraints

Actual package installation tests require Windows and Chocolatey, a large official vendor archive and sufficient disk/network. Bundled Java permits the IDE startup smoke without system Java; independent command-line build tools may need a JDK. Documentation sources are under docs and generated root/.github entrypoints follow docs/config.yml.

The project evidence and public entry points are recorded in the [project card](project-card.md).
This constitution governs this fork's maintenance workflow; it does not claim upstream adoption.
Spec Kit is pinned to 1.2.3 with the native OMP integration and bundled Bug Triage Workflow 1.0.1.
Generated commands/scripts/templates remain generated; use official supported update paths and
preserve local customizations rather than overwriting them.

## Development Workflow

1. Read the project card and source evidence; complete the affected concept's model card on `work`.
2. Use `/speckit.specify` when a new requirement needs a specification, or `/speckit.bug.assess`
   for an evidenced bug. These are agent commands, not shell executables. Read their installed
   instructions and follow their scope guards; this adoption does not initiate bug fixes.
3. Plan the smallest change and verification. Use `/speckit.plan` and `/speckit.tasks` when the
   work needs a feature plan, or the bundled bug workflow's fix/test stages after assessment.
4. Implement only the accepted scope, then run actual targeted verification. Record limitations.
5. Inspect the submission base SHA, commit list, full diff, and changed paths before submission.
   Future owner-repository changes follow the verified base and existing release policy in a separate clean Orca worktree. Keep Spec Kit/card/report commits on work and transfer only intended packaging/test/user-doc changes to any release or submission branch. There is no external upstream-submit branch to fabricate, and no publication is authorized by adoption.
6. Stage only intended contribution paths. Reject mixed commits, work-only artifacts, secrets,
   duplicate work, and unverified success claims. One PR represents one coherent change;
   PR creation, checks, review, and merge are distinct events. Maintainers decide merging.

## Governance

This is the initial 1.0.0 maintenance constitution, ratified on 2026-10-26. Amendments MUST explain
why a rule changes, cite repository evidence, describe migration implications, and update this
version/date through a reviewed `work` change. Use major versions for incompatible governance,
minor for added principles, and patch for clarifications. Reviewers MUST check scope, compatibility,
verification evidence, and submission isolation against this constitution before accepting a change.
If repository instructions or upstream requirements conflict, record the conflict and obtain a
maintainer decision rather than claiming this fork policy overrules upstream requirements.

**Version**: 1.0.0 | **Ratified**: 2026-10-26 | **Last Amended**: 2026-10-26
