class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :flatten_model_errors
  helper :all
  before_action :geocode_user


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

  def geocode_user
    # we don't need to do this on every request
    if !cookies.signed[:geocode_check]
      cookies.signed[:geocode_check] = {
          :value => true,
          :expires => 60.minutes.from_now.utc
      }
      geocode = geocode_from_ip
      if geocode
        cookies[:location] = JSON.generate({
          city: geocode.city_name,
          state: geocode.region_name,
          country: geocode.country_name
        })
      end
    end
  end

  def geocode_from_ip
    ip = Rails.env.development? ? "99.106.119.107" : request.ip
    @ip_geocode ||= GeoIP.new('db/GeoLiteCity.dat').city(ip)
  end

end
