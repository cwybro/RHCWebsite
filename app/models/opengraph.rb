class OpenGraph
    attr_accessor :title, :type, :image_url, :url, :site_name

    def initialize(title, type, url, image_url)
        self.title = title
        self.type = type
        self.url = "http://www.#{ENV['DOMAIN_NAME']}#{url}"
        self.image_url = "http://www.#{ENV['DOMAIN_NAME']}#{image_url}" unless image_url.nil? else nil
    end

    def has_image?
        !self.image_url.nil?
    end
end
