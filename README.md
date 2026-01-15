# Valantic DevOps Challenge – Build & Delivery Automation

## Objective
This repository demonstrates a simple but robust automation to package source code into a versioned archive.  
The solution focuses on Bash scripting, Git workflow, packaging, logging, and basic delivery concepts.

The goal is to show clean automation, reproducibility, and the ability to explain design decisions clearly.

---

## Repository Structure
valantic-devops-challenge/
---- src/ # Sample source files (Python, shell)
----scripts/
--------build_package.sh # Build & packaging script
----VERSION # Project version
----README.md # Documentation
----release/ # Generated build artifacts
----delivery/ # Simulated delivery location
----build.log # Build log (ignored by Git)

---

## Prerequisites
- Linux-based OS
- Bash
- Git
- tar
- Python 3 (for sample files)

---

## How to Run the Build
From the repository root:

```bash
chmod +x scripts/build_package.sh
./scripts/build_package.sh
```
What the script does:
- Validates the presence of the VERSION file
- Cleans old build artifacts.
- Packages all .py, .sh, and .js files into a tarball
- Names the archive using version and timestamp:
  app-<version>-<YYYYMMDD_HHmm>.tar.gz
- Stores the archive in the release/ directory
- Copies the artifact to the delivery/ directory
- Logs all steps to build.log

## Versioning & Release
- The version is read from the VERSION file.
- After a successful build on the main branch, a Git release tag is created:
  v<version>
- Each tag corresponds to a reproducible build artifact.

## Logging & Error Handling
- All build steps are logged with timestamps in build.log.
- The script fails fast on errors (e.g. missing VERSION file).
- Errors are logged clearly to support troubleshooting and automation use cases.

## Possible Improvements for Production Use
If this solution were used in a production environment, the following improvements would be considered:
- Run the build inside a CI/CD pipeline (e.g. Jenkins, GitHub Actions)
- Store artifacts in an artifact repository (e.g. Nexus, Artifactory)
- Add checksum or signature validation for artifacts
- Add automated tests before packaging
- Introduce environment-specific configuration
- Extend logging and monitoring integration

## Git Workflow
- main branch represents a stable, releasable state.
- Development and testing were done on a feature branch.
- Changes were merged into main before creating the release.
- Release tags are created only after successful builds.

## Summary
This challenge demonstrates:
- Clean Bash automation
- Structured Git usage
- Repeatable and traceable builds
- Clear documentation and design decisions
