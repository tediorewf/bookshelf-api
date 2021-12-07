module Api
  module V1
    class UserRepresenter
      def initialize(user)
        @user = user
      end

      def as_json
        {
          id: user.id,
          email: user.email
        }
      end

      private

      attr_reader :user
    end
  end
end
