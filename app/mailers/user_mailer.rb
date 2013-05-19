class UserMailer < ActionMailer::Base
  default "\"FamilyTales\" <hello@familytales.co>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user, url)
    @user = user
    @url = url
    mail :to => user.email, :subject => "Reset your FamilyTales password"
  end
end
