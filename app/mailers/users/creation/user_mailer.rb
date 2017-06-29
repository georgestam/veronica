module Users
  module Creation

    class UserMailer < ApplicationMailer

      # Subject can be set in your I18n file at config/locales/en.yml
      # with the following lookup:
      #
      #   en.user_mailer.welcome.subject
      #
      
      def welcome(user_id)
        @user = User.find(user_id)
        # This will render a view in `app/views/user_mailer`!
        
        if @user.diverlang?
          mail(from: 'cristina@helloveronica.com', to: @user.email, subject: 'Welcome to Diverlang!')
        else
          mail(from: 'cristina@helloveronica.com', to: @user.email, subject: 'Welcome to Veronica!')
        end   
      
      end

      # def reset_password_instructions(user, token, options)
      #   @user = user
      #   @token = token

      #   mail(to: @user.email, subject: "Reset password")
      # end
    end
  end
end 
