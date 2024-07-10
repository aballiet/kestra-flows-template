resource "kestra_flow" "dbt_run" {
  flow_id   = var.flow_id
  namespace = var.namespace
  content = join("", [
    yamlencode({
      id          = var.flow_id
      namespace   = var.namespace
      labels      = var.priority != null ? merge(var.labels, { priority = var.priority }) : var.labels
      description = var.description
    }),
    templatefile("${path.module}/tasks.yml", {
      github-repo-url = var.github_repo_url
      git-branch      = var.git_branch
      dbt-command     = var.dbt_command
      dbt-max-attempt = var.dbt_max_retry_attempt
    }),
    var.trigger,
  ])
}
