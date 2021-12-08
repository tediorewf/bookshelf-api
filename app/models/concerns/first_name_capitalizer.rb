module FirstNameCapitalizer
  extend ActiveSupport::Concern

  protected

  def capitalize_first_name
    self.first_name = first_name.capitalize
  end
end
