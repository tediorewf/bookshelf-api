module TokenHelper
  def token_with_type(type, user_data)
    [type, user_data].join(' ')
  end
end
