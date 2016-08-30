class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user  # Instance variable => available in view

    # This will render a view in `app/views/user_mailer`!
    mail(to: @user.email, subject: 'Welcome to Warwick Car Share')
  end
end
