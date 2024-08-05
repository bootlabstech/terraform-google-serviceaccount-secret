# resource "google_org_policy_policy" "primary" {
#   name   = "projects/${var.project_id}/policies/iam.disableServiceAccountKeyUpload"
#   parent = "projects/${var.project_id}"

#   spec {
#     rules {
#       enforce = "TRUE"
#     }
#   }
# }

# resource "google_project" "basic" {
#   project_id = var.project_id
#   name       = var.project_id
#   org_id     = "361336785498"
# }

resource "google_service_account" "service_account" {
  account_id   = var.name
  project = var.project_id
  display_name = var.name
  description = var.description
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.service_account.name
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = var.name
  project =var.project_id

  labels = {
    label = var.project_id
  }

  replication {
    user_managed {
      replicas {
        location = "asia-south1"
        customer_managed_encryption {
            kms_key_name = var.kms_key
          
        }
      }
    }
  }
}
resource "google_secret_manager_secret_version" "my_secret_version" {
  secret      = google_secret_manager_secret.secret-basic.id
  secret_data = base64decode(google_service_account_key.mykey.private_key)
}

# resource "google_org_policy_policy" "primary_edit" {
#   name   = "projects/${var.project_id}/policies/iam.disableServiceAccountKeyUpload"
#   parent = "projects/${var.project_id}"

#   spec {
#     rules {
#       enforce = "FALSE"
#     }
#   }
#   depends_on = [ google_secret_manager_secret_version.my_secret_version ]
# }