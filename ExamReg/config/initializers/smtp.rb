ActionMailer::Base.smtp_settings = {
    domain: 'megatunger.codes',
    address:        "smtp.sendgrid.net",
    port:            587,
    authentication: :plain,
    user_name:      'apikey',
    password:       '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'
}