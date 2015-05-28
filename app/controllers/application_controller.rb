class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :flatten_model_errors
  helper :all

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to '/log_in' unless current_user
  end

  #
  # Flatten errors message hash into array
  #
  def flatten_model_errors(messages)
    message_array = []

    messages.each do |key, message|

      if message.is_a?(Array)
        message.each do |body|
          message_array.insert(0, "#{( key.to_s.upcase != 'BASE' ? key.to_s.capitalize : '')} #{body}")
        end
      else
        message_array.insert(0, "#{( key.to_s.upcase != 'BASE' ? key.to_s.capitalize : '')} #{message}")
      end
    end

    message_array
  end

end
