module EmailNormalizer
  extend ActiveSupport::Concern

  protected

  def normalize_email
    self.email = email.downcase
  end
end
