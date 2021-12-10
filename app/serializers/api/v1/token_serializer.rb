module Api
  module V1
    class TokenSerializer < Api::V1::ApiBaseSerializer
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
