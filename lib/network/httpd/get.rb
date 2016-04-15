require './base'
module Network 
  module Http
    class Get < Network::Base
      attr_accessor :host, :port, :params
      def initialize( host, params = {})
        @host = host
        @port = 80
        @params = params
      end

      def connect (use_ssl: false )
        uri = URI.parse( self.host )
        uri.query = URI.encode_www_form( self.params )
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
end
