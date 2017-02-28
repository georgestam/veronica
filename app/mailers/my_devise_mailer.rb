class MyDeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  # Overrides same inside Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    if record.domain == 'http://www.diverlang.com' || record.domain == 'http://diverlang.com'
      opts[:subject] = 'Welcome to Diverlang!'
      opts[:from] = 'contact@diverlang.com'
      opts[:reply_to] = 'contact@diverlang.com'
    else
      opts[:subject] = 'Welcome to Veronica!'
      opts[:from] = 'contact@helloveronica.com'
      opts[:reply_to] = 'contact@helloveronica.com'
    end  
    
    super
  end

  # Overrides same inside Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    if record.domain == 'http://www.diverlang.com' || record.domain == 'http://diverlang.com'
      opts[:subject] = 'Welcome to Diverlang!'
      opts[:from] = 'contact@diverlang.com'
      opts[:reply_to] = 'contact@diverlang.com'
    else
      opts[:subject] = 'Welcome to Veronica!'
      opts[:from] = 'contact@helloveronica.com'
      opts[:reply_to] = 'contact@helloveronica.com'
    end  
  end

  # Overrides same inside Devise::Mailer
  def unlock_instructions(record, token, opts={})
    if record.domain == 'http://www.diverlang.com' || record.domain == 'http://diverlang.com'
      opts[:subject] = 'Welcome to Diverlang!'
      opts[:from] = 'contact@diverlang.com'
      opts[:reply_to] = 'contact@diverlang.com'
    else
      opts[:subject] = 'Welcome to Veronica!'
      opts[:from] = 'contact@helloveronica.com'
      opts[:reply_to] = 'contact@helloveronica.com'
    end  
  end

end