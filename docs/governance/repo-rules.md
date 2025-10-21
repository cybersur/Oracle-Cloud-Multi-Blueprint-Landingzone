# Repository Governance and Operational Rules

## 1. Purpose

This document defines the **governance standards**, **operational rules**, and **quality requirements** for  
the **p-pm-tgs-oci-landingzone** repository.

It ensures that every file, module, and workflow adheres to organizational compliance, quality, and security mandates — maintaining the integrity of the OCI Landing Zone architecture across all layers.

---
## 2. Governance Objectives

| Objective | Description |
|------------|--------------|
| **Consistency** | All modules, blueprints, and scripts follow a unified naming and documentation convention. |
| **Traceability** | Every change is reviewed, validated, and traceable through commit history and pipeline logs. |
| **Security** | No secrets, credentials, or sensitive data are committed in plaintext. |
| **Compliance** | Follows Oracle and organizational governance frameworks for cloud and infrastructure code. |
| **Quality Control** | Enforces validation, linting, and review workflows prior to merge. |

---
## 3. Directory Governance Rules

Each directory within the repository must follow the structure defined in `docs/architecture/repo-structure.md`.

| Rule | Description |
|------|--------------|
| **README.md Required** | Each top-level folder must include a `README.md` explaining its purpose. |
| **.keep Placeholder** | Empty folders must include a `.keep` file to maintain structure in Git. |
| **No Mixed Purposes** | Each directory serves a single architectural function (e.g., orchestration, blueprint, pipeline). |
| **Lowercase Naming** | All folder and file names use lowercase letters and underscores (e.g., `layer0_baseline`). |
| **Versioned Modules** | Module directories must include a version tag or be tied to the repo’s release version. |

---
## 4. File Standards

| File Type | Rule |
|------------|------|
| **Terraform (`.tf`)** | Must include header comments with module name, author, and version. |
| **Markdown (`.md`)** | Must begin with a clear title and purpose section. |
| **YAML / JSON** | Must be validated against schema and formatted with 2-space indentation. |
| **Scripts (`.ps1` / `.sh`)** | Must begin with a banner comment defining author, purpose, and execution context. |
| **GitHub Workflows (`.yml`)** | Must include descriptive `name:` field and clear job labels. |

All files must pass repository linters and formatting checks before merge.

---
## 5. Commit and PR Governance
### 5.1 Commit Rules
- Use semantic commit messages (`feat:`, `fix:`, `docs:`, `refactor:`).
- Commits must be **atomic** — one logical change per commit.
- No binary files or large media assets unless explicitly required.

### 5.2 Pull Request Rules
- Each PR must:
  - Reference a ticket, feature ID, or task number.
  - Include updated documentation when new modules or folders are introduced.
  - Pass all automated validations before review.
---

## 6. Security & Compliance Controls 

| Control | Enforcement |
|----------|--------------|
| **No Secrets in Code** | Sensitive values must be stored in OCI Vault or environment variables. |
| **Protected Branches** | `main` and `development` branches are protected against direct pushes. |
| **Signed Commits** | All commits must be GPG-signed or verified through GitHub identity. |
| **Infrastructure State Security** | State files are stored in Object Storage with encryption enabled. |
| **Access Management** | Repository access controlled via GitHub Teams or OCI IAM Federation. |

 **Automation pipelines** must never use hardcoded credentials or plain text secrets.

---
## 7. CI/CD Validation Requirements

Before any PR is merged, the following GitHub Action workflows must pass:

| Workflow | Purpose |
|-----------|----------|
| `tf_validate_plan.yml` | Ensures Terraform syntax, providers, and plan consistency. |
| `blueprint_sync.yml` | Validates that all blueprint YAMLs and registry entries match schema. |
| `orchestrator_bootstrap.yml` | Confirms orchestrator structure and pipeline dependencies. |

Validation jobs must run automatically on each push and pull request targeting `development` or `main`.

---

## 8. Documentation Governance
- All architectural or governance documents reside under `docs/`.  
- Each document must include:
  - Title (`# Heading 1`)
  - Purpose
  - Table or diagram where applicable
  - Author or maintainer attribution (optional)
- Diagrams must be stored in `docs/architecture/architecture/` or referenced externally (no binary blobs in Git).
- All `.md` files must render correctly in GitHub Markdown preview.

---
## 9. Code Quality and Linting

### Required Pre-Merge Checks
| Tool | Scope | Trigger |
|------|--------|----------|
| `terraform fmt` | Format and indentation | Every PR |
| `terraform validate` | Syntax and provider verification | Every PR |
| `yamllint` | YAML formatting and key validation | Every PR |
| `markdownlint` | Markdown consistency check | Every PR |
| `tfsec` or `Checkov` | Security scan for Terraform | Weekly or before production merge |

Failure in any check blocks merge approval until resolved.

---
## 10. Versioning & Release Rules

| Item | Policy |
|------|---------|
| **Version Scheme** | Follows Semantic Versioning (SemVer) — `MAJOR.MINOR.PATCH` |
| **Tagging** | Each merge into `main` triggers a tagged release (`v1.0.0`, `v1.1.0`, etc.) |
| **Change Log** | Every release includes an updated `CHANGELOG.md` with categorized entries |
| **Deprecation Policy** | Deprecated modules must include a header warning and migration path |

---

## 11. Auditing & Review

- Every merge to `main` is auditable through:
  - Commit history
  - CI/CD logs
  - PR reviews
- Quarterly governance reviews must verify:
  - Compliance with directory structure
  - Security policy adherence
  - Terraform and workflow schema validity

Auditing results are tracked in a governance record outside the repo.

---

## 12. Enforcement

Non-compliance with repository rules results in:
- PR rejection until corrected  
- Automated lint or validation failure  
- Escalation to repository maintainers for review  

Compliance automation will eventually be integrated via the **Governance Enforcement Pipeline** in future roadmap phases.
---

## 13. Summary

The **Repository Governance Rules** establish the foundation for sustainable and secure collaboration.  
By enforcing structural discipline, policy compliance, and quality assurance at every layer, this repository ensures consistency across all environments and blueprints.

> **Governance first, automation second.**  
> Code is only as strong as the policies that govern it.

