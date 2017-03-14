class SubscribeToNewsletterService
  def initialize(user)
    @user = user
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @list_id = ENV['MAILCHIMP_LIST_ID']
  end

  def call
    begin
      @gibbon.lists(@list_id).members.create(
        body: {
          email_address: @user.email,
          status: "subscribed",
          # merge_fields: {
          #   FNAME: @user.first_name,
          #   LNAME: @user.last_name
          # }
        }
      )
    rescue => e
      Rails.logger.error e
      raise e unless Rails.env.development?
    end 
  end
end
