module EmailNormalizer
  extend ActiveSupport::Concern

  private

  def normalize_email
    email.downcase!
  end
end
