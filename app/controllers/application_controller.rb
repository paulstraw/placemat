class ApplicationController < ActionController::Base
  force_ssl if Rails.env.production? || Rails.env.staging?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
