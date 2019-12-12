Clearance.configure do |config|
  config.routes = true
  config.mailer_sender = "noreply@megatunger.codes"
  config.rotate_csrf_on_sign_in = true
  config.allow_sign_up = false
end
