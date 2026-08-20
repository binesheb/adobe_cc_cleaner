# Adobe Creative Cloud Cleaner helper

> **Status: legacy maintenance utility.** This repository contains a Windows batch helper around Adobe's Creative Cloud Cleaner Tool. The bundled executable is a third-party vendor tool; this repository does not claim to maintain or modify Adobe's cleaner itself.

## What this repository does

`cccleaner.bat`:

1. launches the bundled cleaner interactively;
2. searches the local `C:\` drive for files named exactly `adobe` and folders whose names begin with `adobe`;
3. takes ownership, grants the local Administrators group access, and deletes matching paths; and
4. invokes the cleaner with `--removeAll=ALL`.

Because the legacy script performs broad, destructive deletion, review the script before running it and back up anything important. Run only on a machine you control and only when you understand the consequences.

## Requirements

- Windows
- Administrator privileges
- A backup or restore point before cleanup

## Run

Open an elevated Command Prompt in the repository folder and run:

```bat
cccleaner.bat
```

Do not interrupt the process while the cleaner is working. The batch script is legacy code and may not be compatible with every current Adobe installation or Windows configuration.

## Updates

### Manual update

For a Git checkout:

```bat
git fetch --tags --prune
git pull --ff-only
```

For reproducible operation, pin a reviewed tag or commit:

```bat
git checkout <tag-or-commit>
```

To roll back, check out a previously known-good tag or commit and verify the files before running them.

### Automatic update

Unattended self-updating is intentionally **not enabled**. This utility can delete files and change ownership, so silently replacing executable or batch content immediately before a destructive operation would be unsafe.

The preferred future model is an **opt-in update check against versioned GitHub Releases**, with release notes shown to the user and explicit confirmation before any download or replacement. Until packaged releases exist, use the manual update procedure above.

## Versioning and releases

This project follows Semantic Versioning:

- **MAJOR** — incompatible or materially changed cleanup behavior.
- **MINOR** — new supported cleanup or recovery capability.
- **PATCH** — documentation, safety, or reliability fixes that preserve the intended behavior.

See `CHANGELOG.md` for release notes. A GitHub Release or tag should only be created when a tested, meaningful revision is ready; this repository does not treat documentation-only commits as proof that the bundled third-party executable has been newly released.

## Next improvements

- Add an explicit dry-run/preflight mode.
- Narrow deletion targets to reviewed locations instead of recursively scanning all of `C:\`.
- Report failed deletions and preserve an operation log.
- Verify the provenance and integrity of any redistributed third-party executable before creating a packaged release.
