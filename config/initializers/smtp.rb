ActionMailer::Base.smtp_settings = {
    domain: 'megatunger.codes',
    address:        "smtp.sendgrid.net",
    port:            587,
    authentication: :plain,
    user_name:      'apikey',
    password:       ENV['SENDGRID_KEY']
}