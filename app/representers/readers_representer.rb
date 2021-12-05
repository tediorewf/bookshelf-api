class ReadersRepresenter
  def initialize(readers)
    @readers = readers
  end

  def as_json
    readers.map do |reader|
      ReaderRepresenter.new(reader).as_json
    end
  end

  private

  attr_reader :readers
end
