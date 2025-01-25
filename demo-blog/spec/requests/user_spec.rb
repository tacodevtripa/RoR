require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "returns http success" do
      # this will perform a GET request to the /user/index route
      get "/user/index"

      # 'response' is a special object which contain HTTP response received after a request is sent
      # response.body is the body of the HTTP response, which here contain a JSON string
      expect(response.body).to eq('{"status":"online"}')

      # we can also check the http status of the response
      expect(response.status).to eq(200)
    end
  end
end
