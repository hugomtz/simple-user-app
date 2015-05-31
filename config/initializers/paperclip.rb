Paperclip.interpolates(:default_url_placeholder) do |attachment, style|
  klass = attachment.instance.class.to_s.downcase
  ActionController::Base.helpers.asset_path("fallback/#{klass}_#{attachment.name}_#{style}.png")
end