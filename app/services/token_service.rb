class TokenService
  HMAC_SECRET = Rails.application.credentials.fetch(:secret_key_base).freeze
  private_constant :HMAC_SECRET

  class << self
    def encode(payload)
      try(:encode!, payload)
    end

    def encode!(payload)
      JWT.encode(payload, HMAC_SECRET)
    end

    def decode(token)
      try(:decode!, token)
    end

    def decode!(token)
      JWT.decode(token, HMAC_SECRET).first
    end
  end
end
