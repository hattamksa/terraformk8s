resource "google_service_account" "service-acct" {
  account_id = "service-acct"
}

resource "google_project_iam_member" "service-acct" {
  project = "cloudtest1"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service-acct.email}"
}

resource "google_service_account_iam_member" "service-acct" {
  service_account_id = google_service_account.service-acct.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:cloudtest1.svc.id.goog[default/service-acct]"
}
