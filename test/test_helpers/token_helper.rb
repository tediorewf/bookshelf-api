module TokenHelper
  def token(type, user_data)
    [type, user_data].join(' ')
  end
end
