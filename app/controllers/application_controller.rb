class ApplicationController < ActionController::API
  include SessionsHelper
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == ENV.fetch('MIFTON_API_TOKEN')
    end
  end
end
