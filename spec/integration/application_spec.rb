require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_artists_table
    reset_albums_table
  end


  context "GET /albums" do
    it "lists all albums" do
      response = get('/albums')
     
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/1">Doolittle</a>')
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/6">Lover</a>')


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
      expect(response.body).to include('<a href="/artists/1">Pixies</a>')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a>')
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

  context "GET /artists/:id" do
    it "returns the HTML content for a single artist" do
      response = get('/artists/1')

      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('genre: Rock')
     
    end

    it "returns the HTML content for another single artist" do
      response = get('/artists/3')

      expect(response.body).to include('<h1>Taylor Swift</h1>')
      expect(response.body).to include('genre: Pop')
    end
  end


end
