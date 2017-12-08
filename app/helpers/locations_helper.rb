module LocationsHelper
    require 'opengraph'
    def geocode(address)
        uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address=#{address}")
        uri = URI.parse(uri)
        uri.open do |f|
            h = JSON.parse(f.read)
            if (h['status'] == 'OK') && !h['results'].empty?
                lat = h['results'][0]['geometry']['location']['lat']
                lon = h['results'][0]['geometry']['location']['lng']
                return [lat.to_d, lon.to_d]
            end
        end
        [nil, nil]
    end

    def geocode_filter_location(location)
        geo = Geokit::Geocoders::MultiGeocoder.geocode location
        return [geo.lat, geo.lng] if geo.success else [nil, nil]
    end

    def get_opengraph_obj(location)
        og = OpenGraph.new(location.title, "website", event_path(location), location.image.url)
    end



end
