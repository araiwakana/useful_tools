module Network
  module Http
    class Post < Network::Http::Base
      attr_accessor :host, :params
      def initialize( host, params = {})
        @host = host
        @params = params
      end

      def connect
        uri = URI.parse( self.host )
        uri.query = URI.encode_www_form( self.params[:query_parameter] )
        self.params.delete(:query_parameter)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path + "?" + uri.query)
        req.set_form_data( self.params )
        res = Net::HTTP.start( uri.host, uri.port, :use_ssl => uri.scheme == "https",:verify_mode => OpenSSL::SSL::VERIFY_NONE ) { |http_obj|
         http_obj.request(req)
        }
        return res.body
      end
    end
  end
end
