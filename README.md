# GitLab CI/CD Components
![CI/CD](https://gitlab.com/hegerdes/gitlab-actions/badges/main/pipeline.svg)
![Release](https://gitlab.com/hegerdes/gitlab-actions/-/badges/release.svg)

This repo contains a collection of different [GotLab CI/CD Components](https://about.gitlab.com/blog/2023/12/21/introducing-the-gitlab-ci-cd-catalog-beta/) and snippets to be included in the script section of a job.

Currently sported components are:
 * [Code Quality: pre-commit](https://gitlab.com/hegerdes/gitlab-actions/-/tree/main/templates/pre-commit.md)
 * [Build: Helm package](https://gitlab.com/hegerdes/gitlab-actions/-/tree/main/templates/helm-package.md)
 * [Container Build: Kaniko](https://gitlab.com/hegerdes/gitlab-actions/-/tree/main/templates/kaniko-build.md)
 * [Container Build: Buildah](https://gitlab.com/hegerdes/gitlab-actions/-/tree/main/templates/buildash-build.md)
 * [Deployment: Helm install/upgrade](https://gitlab.com/hegerdes/gitlab-actions/-/tree/main/templates/helm-install.md)

Currently sported snippets are:
 * debian-core-tools
 * alpine-core-tools
 * terraform-install
 * git-install
 * tflint-install
 * kubectl-install
 * helm-install
 * kubeseal-install
 * kubeconform-install
 * kind-install
 * tailscale-install
 * minio-mc-install
 * yq-by-mike-farah-install
 * azure-cli-install
 * aws-cli-install

**NOTE:** All components and snippets are `arm64` ready. Gitlab now offers hosted ARM runners. You can use these when setting:
```yaml
default:
  tags: [saas-linux-medium-arm64]

# or by including as a template and setting it by extending the job
include:
  - component: gitlab.com/hegerdes/gitlab-actions/kaniko-build@<VERSION>
    inputs:
      as_job: .my-kaniko-build

my-kaniko-build:
  tags: [saas-linux-medium-arm64]
  extends: .my-kaniko-build
```

## Contribute

Feel free to open a issue or a PR. Any new CI tasks must have tests for them and must run on amd64 and arm64.
Please read about CI/CD components and best practices at: https://docs.gitlab.com/ee/ci/components
