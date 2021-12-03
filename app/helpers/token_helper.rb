class TokenService
  class << self
    def encode(payload)
      lifetime = Rails.application.config.x.token.lifetime
      expiration = lifetime.from_now.to_i
      payload.merge!(exp: expiration)
      hmac_secret = Rails.application.credentials.fetch(:secret_key_base)
      JWT.encode(payload, hmac_secret)
    end

    def decode(token)
      hmac_secret = Rails.application.credentials.fetch(:secret_key_base)
      JWT.decode(token, hmac_secret).first
    end
  end
end
