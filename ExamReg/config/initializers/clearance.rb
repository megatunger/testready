Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = "noreply@megatunger.codes"
  config.rotate_csrf_on_sign_in = true
  config.allow_sign_up = false
  config.redirect_url = "/admin/dashboard_admin"
end
