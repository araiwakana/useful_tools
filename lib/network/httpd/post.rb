module Network
  module Http
    class Post < Network::Http::Base
      attr_accessor :host, :params
      def initialize( host, params = {})
        @host = host
        @params = params
      end

      def connect
        uri = URI.parse( host )
        uri.query = params[:query_parameter].nil? ? "" : URI.encode_www_form( params[:query_parameter] )
        params.delete(:query_parameter)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path + "?" + uri.query, initheader = params[:header])
        req.set_form_data( params )
        res = Net::HTTP.start( uri.host, uri.port, :use_ssl => uri.scheme == "https",:verify_mode => OpenSSL::SSL::VERIFY_NONE ) { |http_obj|
         http_obj.request(req)
        }
        return res.body
      end
    end
  end
end
