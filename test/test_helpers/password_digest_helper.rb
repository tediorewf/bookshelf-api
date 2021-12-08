module PasswordDigestHelper
  def password_digest(password)
    BCrypt::Password.create(password)
  end
end

