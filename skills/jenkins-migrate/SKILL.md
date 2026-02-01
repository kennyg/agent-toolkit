---
name: jenkins-migrate
description: Convert Jenkins pipelines (Jenkinsfiles) to GitHub Actions workflows. Use when migrating CI/CD from Jenkins to GitHub Actions, converting a Jenkinsfile, or when user mentions Jenkins pipeline migration.
---

# Jenkins Migration

Convert Jenkins Declarative and Scripted Pipelines to GitHub Actions workflows.

## Official Resources

GitHub provides automated migration tooling:

- [GitHub Actions Importer](https://docs.github.com/en/actions/migrating-to-github-actions/using-github-actions-importer-to-automate-migrations/migrating-from-jenkins-with-github-actions-importer) - `gh actions-importer` CLI for automated conversion
- [Migration Guide](https://docs.github.com/actions/learn-github-actions/migrating-from-jenkins-to-github-actions) - Official conceptual mapping

This skill provides detailed mappings for manual conversion and edge cases the automated tool misses.

## Quick Reference

| Jenkins | GitHub Actions |
|---------|----------------|
| `pipeline {}` | `.github/workflows/*.yml` |
| `agent any` | `runs-on: ubuntu-latest` |
| `stages {}` | `jobs:` |
| `steps {}` | `steps:` |
| `environment {}` | `env:` |
| `when { branch 'main' }` | `if: github.ref == 'refs/heads/main'` |
| `parallel {}` | Multiple jobs (parallel by default) |
| `post { always {} }` | `if: always()` |
| `input` (approval) | `environment:` with reviewers |

See [references/concept-mappings.md](references/concept-mappings.md) for complete mappings.

## Conversion Workflow

### 1. Analyze the Jenkinsfile

Identify:
- Pipeline type (Declarative vs Scripted)
- Stages and their purposes
- Build tools (Maven, Gradle, npm, etc.)
- Jenkins plugins referenced
- Environment variables and credentials
- Triggers (cron, webhooks, SCM polling)
- Post-build actions
- Shared library usage (`@Library`)

### 2. Ask Clarifying Questions

For complex pipelines:

1. **Shared libraries** - "I see `@Library('my-lib')`. Do you have an equivalent reusable workflow?"
2. **Credentials** - "This uses credentials 'deploy-key'. What secrets should I reference?"
3. **Triggers** - "Jenkins uses pollSCM. Convert to push-based triggers?"
4. **Approvals** - "There's an `input` step. Use GitHub Environments with required reviewers?"
5. **Runners** - "GitHub-hosted or self-hosted runners?"

### 3. Generate Workflow

Apply mappings from reference docs:
- [Concept Mappings](references/concept-mappings.md) - Core Jenkins → GHA concepts
- [Plugin Mappings](references/plugin-mappings.md) - Jenkins plugins → GHA actions
- [Shared Libraries](references/shared-libraries.md) - Converting to reusable workflows
- [Enterprise Config](references/enterprise-config.md) - Action mirrors, self-hosted runners
- [Best Practices](references/best-practices.md) - SHA pinning, caching, security

### 4. Document Setup Requirements

Always list:
- Secrets to configure
- GitHub Environments to create
- OIDC trust policies (if applicable)
- Manual steps needed

## Key Patterns

### Parallel Stages → Parallel Jobs

```groovy
// Jenkins
parallel {
    stage('Unit') { steps { sh 'npm test:unit' } }
    stage('Lint') { steps { sh 'npm run lint' } }
}
```

```yaml
# GitHub Actions - jobs run in parallel by default
jobs:
  unit:
    runs-on: ubuntu-latest
    steps:
      - run: npm test:unit
  lint:
    runs-on: ubuntu-latest
    steps:
      - run: npm run lint
```

### Credentials → Secrets + OIDC

```groovy
// Jenkins
withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws']]) {
    sh 'aws s3 ls'
}
```

```yaml
# GitHub Actions - prefer OIDC over stored secrets
permissions:
  id-token: write
steps:
  - uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
      aws-region: us-east-1
  - run: aws s3 ls
```

### Manual Approval → Environments

```groovy
// Jenkins
input message: 'Deploy to prod?', submitter: 'release-team'
```

```yaml
# GitHub Actions - configure required reviewers in repo settings
jobs:
  deploy:
    environment: production
```

## Output Checklist

When generating a workflow:

- [ ] SHA-pinned actions with version comments (e.g., `@abc123 # v4.1.1`)
- [ ] `timeout-minutes` set on all jobs
- [ ] `concurrency` group to prevent duplicate runs
- [ ] Caching enabled for dependencies
- [ ] Least-privilege `permissions`
- [ ] Secrets listed in setup requirements
- [ ] OIDC recommended over stored credentials

## Examples

- [Simple Pipelines](references/examples/simple-pipelines.md) - Basic build, test, deploy
- [Complex Pipeline](references/examples/complex-pipeline.md) - Full CI/CD with parallel tests, Docker, K8s
