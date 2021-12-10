module Api
  module V1
    class UserSerializer < Api::V1::ApiBaseSerializer
      attributes :email, :token

      def token
        TokenService.encode(sub: object.id)
      end
    end
  end
end
