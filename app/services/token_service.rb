class TokenService
  HMAC_SECRET = Rails.application.credentials.fetch(:secret_key_base).freeze
  private_constant :HMAC_SECRET

  class << self
    def encode(payload)
      encode!(payload)
    rescue  # because it has "BANG!" version
      nil
    end

    def encode!(payload)
      JWT.encode(payload, HMAC_SECRET)
    end

    def decode(token)
      decode!(token)
    rescue  # because it has "BANG!" version
      nil
    end

    def decode!(token)
      JWT.decode(token, HMAC_SECRET).first
    end
  end
end
