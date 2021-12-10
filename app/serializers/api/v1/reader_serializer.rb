module Api
  module V1
    class ReaderSerializer < Api::V1::ApiBaseSerializer
      attributes :email, :name, :phone
    end
  end
end
