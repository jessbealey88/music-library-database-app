# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method: POST
  * the path: /artists
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body): name=Wild nothing, genre=Indie
 

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->
(No content)


## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /artists with body parameters: name=Wild nothing
genre=Indie

# Expected response:

Response for 200 OK
```
(No content)
```
# Request:

GET /artists

# Expected response:

Response for 200 OK
```
includes 'Wild nothing'
```
## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

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
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

