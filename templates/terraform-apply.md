# Terraform: Module

### Usage

Use this component to setup a full terraform/openToFu validate, plan apply setup.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: $CI_SERVER_HOST/hegerdes/gitlab-actions/terraform-apply@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add `TERRAFORM:fmt`,`TERRAFORM:validate`,`TERRAFORM:plan`,`TERRAFORM:apply` job to the pipeline.  


The template should work without modifications but you can customize the template settings.  
For customization you can use the inputs below or override the jobs. Changes that apply to all jobs can override `.terraform_template:`

### Inputs

| Input                   | Default value                                                                          | Description                                                                                |
| ----------------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `job_prefix`            | `TERRAFORM:`                                                                           | The name prefix of the jobs that will be included with this component.                     |
| `image`                 | `registry.gitlab.com/components/opentofu/gitlab-opentofu:latest-opentofulatest-debian` | The container image to publish                                                             |
| `terraform_root`        | `$CI_PROJECT_DIR`                                                                      | The relative path to the root directory of the Terraform project                           |
| `terraform_environment` | `${CI_PROJECT_NAME}`                                                                   | The name of the enviorment. Defaults to the project name but can be DEV, STAGING, or PROD. |
| `oidc_audience`         | `${CI_SERVER_HOST}`                                                                    | The OIDC audience claim value needed for federated id_token exchange.                      |
| `rules`                 | *Branch,PR,Tag(for apply)*                                                             | The rules when the job runs                                                                |

### Variables

| Variable                         | Description                        |
| -------------------------------- | ---------------------------------- |
| `GIT_STRATEGY`                   | Default to `fetch`.                |
| `MY_GITLAB_TOFU_PLAN_EXTRA_ARGS` | Extra ARGS for `gitlab-tofu plan`. |
| `GITLAB_TOFU_VAR_FILES`          | Path to a var file.                |
