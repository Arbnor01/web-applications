require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context 'GET /albums' do
    it "should return a list of albums" do
      response = get("/albums")

      expected_response = ("Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring")

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
      
    end
  end

  context 'POST /albums' do
    it 'should create a new album' do
      # Send a POST request to the '/albums' endpoint with the necessary parameters
      response = post(
        '/albums',
        title: 'OK Computer', 
        release_year: '1997', 
        artist_id: '1'
      )
       # Verify that the response status is 200 (OK)
      expect(response.status).to eq(200)
      # Verify that the response body is empty
      expect(response.body).to eq('')

      response = get('/albums')

      expect(response.body).to include('OK Computer')
    end
  end
end
