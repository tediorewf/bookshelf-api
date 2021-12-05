module FirstNameCapitalizer
  extend ActiveSupport::Concern

  private

  def capitalize_first_name
    first_name.capitalize!
  end
end
