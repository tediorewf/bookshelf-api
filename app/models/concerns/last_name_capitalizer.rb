module LastNameCapitalizer
  extend ActiveSupport::Concern

  protected

  def capitalize_last_name
    self.last_name = last_name.capitalize
  end
end
