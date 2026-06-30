# Terraform: Module

### Usage

Use this component to publish a terraform module to the integrated GitLab registry.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: $CI_SERVER_HOST/hegerdes/gitlab-actionsterraform-module@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `TERRAFORM:publish` job to the pipeline.  


The template should work without modifications but you can customize the template settings.
### Inputs

| Input            | Default value            | Description                                                                                                 |
| ---------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------- |
| `as_job`         | `TERRAFORM:publish`      | The name of the job that gets imported. Use ".my_job" to include as template.                               |
| `stage`          | `build`                  | The stage where you want the job to be added.                                                               |
| `image`          | `curlimages/curl:latest` | The container image to publish                                                                              |
| `module_name`    | `$CI_PROJECT_NAME`       | The name of your Terraform module, must not have any spaces or underscores (will be translated to hyphens). |
| `module_dir`     | `$CI_PROJECT_DIR`        | The relative path to the root directory of the Terraform project                                            |
| `module_system`  | `local`                  | The system or provider your Terraform module targets (ex. local, aws, google)                               |
| `module_version` | `$CI_COMMIT_TAG`         | The version - it's recommended to follow SemVer for Terraform Module Versioning                             |
| `rules`          | *Tags*                   | The rules when the job runs                                                                                 |

### Variables

| Variable       | Description         |
| -------------- | ------------------- |
| `GIT_STRATEGY` | Default to `fetch`. |
