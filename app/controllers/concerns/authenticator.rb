module Authenticator
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token

  included do
    rescue_from JWT::DecodeError, ActiveRecord::RecordNotFound,
                with: :authentication_failed
    before_action :authenticate_user
  end

  private

  def authenticate_user
    token, _ = token_and_options(request)
    decoded_token = TokenService.decode(token)
    user_id = decoded_token['sub']
    @current_user = User.find(user_id)
  end

  def authentication_failed(e)
    render json: { error: e.message }, status: :unauthorized
  end

  attr_reader :current_user
end
