
resource "google_os_config_patch_deployment" "patch" {
  patch_deployment_id = var.patch_management_id

  instance_filter {
    all = var.instance_filter.all
    group_labels {
      labels = var.instance_filter.group_labels.labels
    }
    instance_name_prefixes = var.instance_filter.instance_name_prefixes
    zones                  = var.instance_filter.zones
  }

  patch_config {
    reboot_config = var.patch_config.reboot_config

    apt {
      type     = var.patch_config.apt.type
      excludes = var.patch_config.apt.excludes
    }
    windows_update {
      classifications = var.patch_config.windows_update.classifications
    }
    pre_step {
      linux_exec_step_config {
        allowed_success_codes = var.patch_config.pre_step.linux_exec_step_config.allowed_success_codes
        interpreter           = var.patch_config.pre_step.linux_exec_step_config.interpreter
        gcs_object {
          bucket            = var.patch_config.pre_step.linux_exec_step_config.gcs_object.bucket
          object            = var.patch_config.pre_step.linux_exec_step_config.gcs_object.object
          generation_number = var.patch_config.pre_step.linux_exec_step_config.gcs_object.generation_number
        }
      }
      windows_exec_step_config {
        allowed_success_codes = var.patch_config.pre_step.windows_exec_step_config.allowed_success_codes
        interpreter           = var.patch_config.pre_step.windows_exec_step_config.interpreter
        gcs_object {
          bucket            = var.patch_config.pre_step.windows_exec_step_config.gcs_object.bucket
          object            = var.patch_config.pre_step.windows_exec_step_config.gcs_object.object
          generation_number = var.patch_config.pre_step.windows_exec_step_config.gcs_object.generation_number
        }
      }
    }
  }
  duration = var.duration

  recurring_schedule {
    time_zone {
      id = var.recurring_schedule.time_zone.id
    }

    time_of_day {
      hours   = var.recurring_schedule.time_of_day.hours
      minutes = var.recurring_schedule.time_of_day.minutes
      seconds = var.recurring_schedule.time_of_day.seconds
      nanos   = var.recurring_schedule.time_of_day.nanos
    }

    monthly {
      week_day_of_month {
        week_ordinal = var.recurring_schedule.monthly.week_day_of_month.week_ordinal
        day_of_week  = var.recurring_schedule.monthly.week_day_of_month.day_of_week
      }
    }
  }
  rollout {
    mode = var.rollout.mode
    disruption_budget {
      percentage  = var.rollout.disruption_budget.percentage
    }
  }
}

