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
     
      expect(response.status).to eq(200)
      expect(response.body).to include('Doolittle')
      expect(response.body).to include('Super Trouper')
      expect(response.body).to include('Lover')


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

  context "GET /albums/:id" do
    it "returns the HTML content for a single album" do
      response = get('/albums/1')

      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies') 
      

    end

    it "returns the HTML content for another single album" do
      response = get('/albums/3')

      expect(response.body).to include('Waterloo')
      expect(response.body).to include('Release year: 1974')
      expect(response.body).to include('Artist: ABBA')
    end
  end

end
