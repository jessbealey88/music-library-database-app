require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "Get /albums" do
    it "lists all albums" do
      response = get('/albums')
      expected_response = 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

      expect(response.status).to eq(200)
      expect(response.body).to eq (expected_response)


    end
  
  end

  context "POST /albums" do
    it 'creates a new album' do

      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      get_response = get('/albums')

      expect(get_response.body).to include('Voyage')
    end
  end

  context "GET /artists" do
    it 'returns a list of all artists' do

      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Pixies, ABBA, Taylor Swift, Nina Simone')
    end
  end

  context "POST /artists" do
    it 'creates a new artist' do

      response = post('/artists', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      get_response = get('/artists')

      expect(get_response.body).to include('Wild nothing')
    end
  end

end
