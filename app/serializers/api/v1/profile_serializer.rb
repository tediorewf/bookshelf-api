module Api
  module V1
    class ProfileSerializer < Api::V1::ApiBaseSerializer
      type :profile

      attributes :email
    end
  end
end

