require './base'
module Network 
  module Http
    class Get < Network::Http::Base
      attr_accessor :host, :params
      def initialize( host, params = {})
        @host = host
        @params = params
      end

      def connect
        uri = URI.parse( self.host )
        uri.query = URI.encode_www_form( self.params )
        p uri
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Get.new( uri.path + "?" + uri.query)
        res = Net::HTTP.start( uri.host, uri.port, :use_ssl => uri.scheme == "https",:verify_mode => OpenSSL::SSL::VERIFY_NONE ) { |http_obj|
         http_obj.request(req)
        }
        return res.body
      end
    end
  end
end
