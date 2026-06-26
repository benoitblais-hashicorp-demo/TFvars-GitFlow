# AGENTS.md for TFvars GitFlow Demo

This file provides instructions for AI coding agents working on this repository.

## Project Purpose

This repository demonstrates how to handle GitFlow with Terraform tfvars files.
The focus is branch strategy, variable file organization, and safe promotion across environments.

## Source of Truth

- This AGENTS.md file is the source of truth for agent behavior in this repository.
- Keep the implementation simple and centered on tfvars workflow patterns.

## GitFlow Branch Model

Use this three-branch model:

- main: production-ready state.
- dev: integration branch for ongoing changes.
- test: validation branch between dev and main.

Promotion direction:

- dev -> test -> main

Do not propose direct promotion from dev to main unless explicitly requested by a human.

## tfvars Directory Structure

Store tfvars in an environment folder with one subfolder per environment.

Required pattern:

```text
environment/
  dev/
    *.tfvars
  test/
    *.tfvars
  prod/
    *.tfvars
```

Notes:

- Each environment subfolder can contain one or more tfvars files.
- Keep naming explicit and environment-scoped.
- Avoid duplicating values across files when a shared variable definition can be used.

## Workspace Targeting Rules

- Workspace configuration must target one explicit tfvars file path.
- Do not use ambiguous wildcards for runtime variable selection.
- When making changes, preserve the selected environment path unless the user asks to switch it.

Example target path shape:

- environment/dev/app.tfvars

## Agent Change Policy

- Keep changes minimal and aligned to the requested branch and environment.
- Do not modify files for other environments unless requested.
- Do not refactor unrelated Terraform code during tfvars workflow updates.

## Validation Expectations

- Prefer producing Terraform that is already style-compliant.
- If local execution is available, run fmt and validate before finalizing changes.
- If local execution is not available, clearly state that validation was deferred to CI.

## Security and Secrets

- Never commit secrets in tfvars files.
- Commit only non-sensitive example values when needed for demonstration.
- Use sensitive workspace variables or secret backends for real credentials.
- Mark sensitive Terraform inputs with sensitive = true where applicable.

## Naming Conventions

- Use lowercase snake_case for variable names.
- Use clear environment labels in file names when helpful.
- Keep branch names and environment folder names consistent.

## Terraform File Conventions

The root module uses these canonical files:

- versions.tf: Terraform version constraint.
- variables.tf: all input variables with type and description.
- outputs.tf: all outputs in alphabetical order.

The `environment` variable is the primary input variable. Its value is always sourced from the environment-scoped tfvars file targeted by the workspace. It must be validated against the allowed values: dev, test, prod.

## Out of Scope

- Do not introduce unrelated architecture patterns or platform migrations.
- Do not add complex tooling unless explicitly requested.
