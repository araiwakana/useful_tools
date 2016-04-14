module Network
  class Get
    attr_accessor :host, :port
    def initialize( host, port = 80 )
      @host = host
      @port = port
    end

    def connect (use_ssl: false )
      uri = URI.parse( self.host )
      http = Net::HTTP.new(uri.host, uri.port)
      if use_ssl
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      req = Net::HTTP::Get.new( uri.path )
      res = Net::HTTP.start( uri.host, uri.port ) { |http_obj|
       http_obj.request(req)
      }
      return res.body
    end
  end
end
