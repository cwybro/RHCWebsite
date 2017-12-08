module EventsHelper
    require 'opengraph'
    def get_opengraph_obj(event)
        og = OpenGraph.new(event.title, "website", event_path(event), event.image.url)
    end
end
