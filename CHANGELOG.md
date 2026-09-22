# Changelog

All notable changes to this repository are documented here.

The project follows [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- Added a least-privilege Windows CI workflow that verifies the bundled cleaner is present and checks that the batch helper still contains its explicit destructive operations without executing them.
- Added `--dry-run` mode to enumerate matching Adobe files and folders without changing files or executing the bundled cleaner.
- Added an explicit interactive confirmation before destructive cleanup starts.

### Fixed

- Kept CI validation non-destructive so repository checks cannot run the cleanup workflow.
- Added an administrator preflight so the destructive helper aborts before cleanup when it is not running elevated.
- Abort cleanup if the bundled Adobe cleaner is missing or its initial launch fails, preventing the broad filesystem cleanup from continuing after a failed cleaner preflight.
- Report failed file and folder deletions instead of claiming every requested deletion succeeded.
- Propagate cleanup and bundled-cleaner failures through the helper's exit status so callers and scripts can reliably detect an unsuccessful cleanup.

## [0.1.1] - 2026-08-20

### Changed

- Added a clear description of the legacy cleanup workflow and its destructive scope.
- Added prerequisites, safe-use guidance, manual update commands, revision pinning, and rollback guidance.
- Defined an opt-in, release-based automatic update strategy instead of unattended self-replacement.
- Documented project-specific release/versioning rules and follow-up reliability work.
