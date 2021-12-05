class BorrowingRepresenter
  def initialize(borrowing)
    @borrowing = borrowing
  end

  def as_json
    {
      id: borrowing.id,
      reader: reader_name,
      book: book_name
    }
  end

  private

  def reader_name
    "#{borrowing.reader.first_name} #{borrowing.reader.last_name}"
  end

  def book_name
    "#{borrowing.book.title}, #{borrowing.book.author}"
  end

  attr_reader :borrowing
end
