class ApplicationMailer < ActionMailer::Base

  default from: 'cristina@helloveronica.com'
  
  def self.inherited(subclass)
    subclass.default template_path: "mailers/#{subclass.name.to_s.underscore}"
    subclass.layout 'mailer'
  end
  
  # layout 'mailer'

end
