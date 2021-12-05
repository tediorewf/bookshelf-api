module LastNameCapitalizer
  extend ActiveSupport::Concern

  private

  def capitalize_last_name
    last_name.capitalize!
  end
end
