require 'httparty'

class PlacesService
  GEOCODING_URL = "https://maps.googleapis.com/maps/api/geocode/json?"
  PLACES_URL = "https://places.googleapis.com/v1/places:searchNearby"


  def initialize(postal_code)

    @postal_code = 10437

  end

  def call

    coordenadas = fetch_coordinates

    # coordina todo y devuelve el resultado (público)
    return fetch_places(coordenadas)



  end

  private


  def fetch_coordinates
    # llama a Geocoding API, devuelve lat y lng (privado)
    url = "#{GEOCODING_URL}address=#{@postal_code}&key=#{api_key}"

    #aqui se obtiene el objeto de datos JSON
    response = HTTParty.get(url)
    # se usa parse JSON para convertir string en estructura de datos o hash
    data = JSON.parse(response.body)

    #extraigo unicamente las coordenadas del codigo postal
    coordenadas_CP = data["results"][0]["geometry"]["location"]
    #puts response
    #puts data

    return coordenadas_CP

  end

  def fetch_places(coord)
    # llamo el metodo fetch_coordinates para obtener lat y lng

    latitud = coord["lat"]
    longitud = coord["lng"]


    # llama a Places API con lat y lng, devuelve el lugar (privado)
    url = "https://places.googleapis.com/v1/places:searchNearby"

    headers = {
      'Content-Type' =>  'application/json',
      'X-Goog-Api-Key' => Rails.application.credentials.google_places_key,
      'X-Goog-FieldMask' => 'places.displayName,places.formattedAddress,places.rating'
    }

    body = {
      "includedTypes" => ["restaurant"],
      "maxResultCount" => 4,
      "locationRestriction" => {
        "circle" => {
          "center" => {
            "latitude" => latitud,
            "longitude" => longitud},
            "radius" => 800
        }
      }
    }.to_json

    result = HTTParty.post(url, headers: headers, body: body)

    #puts result

    return result

  end


  def api_key

    Rails.application.credentials.google_places_key

  end


end
