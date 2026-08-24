# Changelog

All notable changes to this repository are documented here.

The project follows [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- Added a least-privilege Windows CI workflow that verifies the bundled cleaner is present and checks that the batch helper still contains its explicit destructive operations without executing them.

### Fixed

- Kept CI validation non-destructive so repository checks cannot run the cleanup workflow.

## [0.1.1] - 2026-08-20

### Changed

- Added a clear description of the legacy cleanup workflow and its destructive scope.
- Added prerequisites, safe-use guidance, manual update commands, revision pinning, and rollback guidance.
- Defined an opt-in, release-based automatic update strategy instead of unattended self-replacement.
- Documented project-specific release/versioning rules and follow-up reliability work.
