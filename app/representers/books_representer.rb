class BooksRepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    books.map do |book|
      BookRepresenter.new(book).as_json
    end
  end

  private

  attr_reader :books
end
