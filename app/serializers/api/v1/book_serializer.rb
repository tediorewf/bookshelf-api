module Api
  module V1
    class BookSerializer < Api::V1::ApiBaseSerializer
      type :book

      attributes :author, :title
    end
  end
end
