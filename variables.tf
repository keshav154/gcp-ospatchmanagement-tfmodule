variable "patch_management_id" {
  type    = string
  default = "patch-deploy"
}

variable "instance_filter" {
  type = object({
    all = bool
    group_labels = object({
      labels = map(string)
      }
    )
    instance_name_prefixes = list(string)
    zones                  = list(string)
  })
  default = null
}

variable "patch_config" {
  type = object({
    reboot_config = string
    apt = object({
      type     = string
      excludes = list(string)
    })
    windows_update = object({
      classifications = list(string)
    })
    pre_step = object({
        linux_exec_step_config = object({
            allowed_success_codes = list(number)
            interpreter           = string
            gcs_object = object({
                bucket            = string
                object            = string
                generation_number = string
        })
    })
        windows_exec_step_config = object({
            allowed_success_codes = list(number)
            interpreter           = string
            gcs_object = object({
                bucket            = string
                object            = string
                generation_number = string
        })
        })
    })
  })
  default = null
}

variable "duration" {
  type    = string
  default = ""
}

variable "recurring_schedule" {
  type = object({
    time_zone = object({
      id = string
    })
    time_of_day = object({
      hours   = number
      minutes = number
      seconds = number
      nanos   = number
    })
    monthly = object({
      week_day_of_month = object({
        week_ordinal = number
        day_of_week  = string
      })
    })
  })
  default = null
}

variable "rollout" {
  type = object({
    mode = string
    disruption_budget = object({
      percentage = string
      })
})
  default = {
    mode = "ZONE_BY_ZONE"
    disruption_budget = {
        percentage = 25
    }
  }
}

variable "linux_prestep_config" {
  type = object({
    allowed_success_codes = list(number)
    interpreter           = string
    gcs_object = object({
      bucket            = string
      object            = string
      generation_number = string
    })
  })
  default = {
    allowed_success_codes = null
    interpreter = null
    gcs_object = {
        bucket = null
        object = null
        generation_number = null
    }
  }
}

variable "windows_prestep_config" {
  type = object({
    allowed_success_codes = list(number)
    interpreter           = string
    gcs_object = object({
      bucket            = string
      object            = string
      generation_number = string
    })
  })
  default = {
    allowed_success_codes = null
    interpreter = null
    gcs_object = {
        bucket = null
        object = null
        generation_number = null
  }
  }
}