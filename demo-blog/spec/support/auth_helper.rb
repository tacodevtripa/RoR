module AuthHelper
  def generate_jwt_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key!, 'HS256')
  end
end

RSpec.configure do |config|
  config.include AuthHelper
end
