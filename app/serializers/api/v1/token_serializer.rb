module Api
  module V1
    class TokenSerializer < ApiBaseSerializer
      type :token

      attributes :email, :token

      def email
        object.email
      end

      def token
        TokenService.encode(sub: object.id)
      end
    end
  end
end
