RailsAdmin.config do |config|

  config.model Article do
    # new do
    #   field :title, :text
    #   field :text, :ck_editor
    #   field :description, :text
    # end
    edit do
      field :title, :string
      field :description, :ck_editor
      field :locale, :string
      field :private, :boolean
      field :photo, :carrierwave
    end
  end
  
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  config.authorize_with :pundit

  # config.model User do
  #   edit do
  #     # For RailsAdmin >= 0.5.0
  #     field :description, :ck_editor
  #     # For RailsAdmin < 0.5.0
  #     # field :description do
  #     #   ckeditor true
  #     # end
  #   end
  # end

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.authorize_with do |controller|
    redirect_to main_app.root_path unless current_user && current_user.admin
  end

end
