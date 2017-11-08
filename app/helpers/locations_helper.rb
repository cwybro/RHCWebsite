module LocationsHelper
    def geocode(address)
      uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address=#{address}")
      uri = URI.parse(uri)
      uri.open do |f|
        h = JSON.parse(f.read)
        if h['status'] == 'OK' and h['results'].length > 0
          lat = h['results'][0]['geometry']['location']['lat']
          lon = h['results'][0]['geometry']['location']['lng']
          return [lat.to_d, lon.to_d]
        end
      end
      return [nil, nil]
    end
end
