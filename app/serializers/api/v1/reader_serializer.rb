module Api
  module V1
    class ReaderSerializer < Api::V1::ApiBaseSerializer
      type :reader

      attributes :email, :first_name, :last_name, :phone
    end
  end
end
