# AGENTS

This repository contains shell configuration and setup scripts for macOS. Use the notes below when making changes or adding new scripts so automation remains safe, repeatable, and easy to review.

## Project overview

- Primary language: Bash/sh
- Entry points: `bootstrap.sh`, `brew.sh`, `fix_errors.sh`
- Documentation: see [docs/](docs/) and [docs/PROMPT_TRUECOLOR.md](docs/PROMPT_TRUECOLOR.md)

## How to work in this repo

- Prefer small, reviewable changes; avoid large refactors unless asked.
- Preserve existing behavior unless a change request is explicit.
- Keep scripts compatible with macOS default tools (BSD utilities) unless the script already relies on GNU tooling.
- Avoid introducing non-ASCII characters in scripts unless there is a clear reason.

## Bash scripting best practices

- Use `#!/usr/bin/env bash` for scripts that require Bash features; use `#!/bin/sh` only for POSIX shells.
- Enable strict mode when appropriate for new scripts: `set -euo pipefail` and `IFS=$'\n\t'` (document any exceptions).
- Quote variables and command substitutions: `"$var"`, `"$(cmd)"`.
- Prefer `[[ ... ]]` over `[ ... ]` for conditionals in Bash.
- Avoid parsing `ls`; use globs or `find`.
- Use `printf` instead of `echo` for predictable output.
- Use functions to group logic; keep them small and return non-zero on failure.
- Check command availability before use: `command -v foo >/dev/null 2>&1`.
- Prefer arrays for lists to avoid word-splitting bugs.
- Avoid backticks; use `$(...)`.
- Handle paths with spaces; never assume `cd` succeeded without checking.
- Fail fast on missing inputs; validate required environment variables.
- Use `mktemp` for temporary files and clean them up with `trap`.
- Keep side effects explicit and logged when changes affect user state.

## Testing and safety

- Run scripts in a clean shell when possible.
- Avoid interactive prompts in automation unless explicitly required; provide a `-f` or `--force` option for non-interactive use.
- When modifying setup scripts, consider idempotency (safe to run multiple times).
