module ChatWork
  class Base
  	attr_accessor :base_end_point
  	@@header = {'X-ChatWorkToken' => ChatWork::Constants::API_TOKEN}

    def set_base_point
      @base_end_point = self.class.class_eval { class_variable_get(:@@end_point) }
    end
    def http_get(uri, params = {})
      set_api_token( params )
      Network::Http::Get.new( uri, params ).connect
    end
    def http_post(uri, params = {})
      set_api_token( params )
      Network::Http::Post.new( uri, params ).connect
    end
    def http_put(uri, params = {})
      set_api_token( params )
      Network::Http::Put.new(uri).connect
    end
    def http_delete(uri, params = {})
      set_api_token( params )
      Network::Http::Delete.new( uri, params ).connect
    end
    def http_patch
      set_api_token( params )
      Network::Http::Patch.new( uri, params ).connect
    end

    def set_api_token( params )
      params.merge!( {:header => @@header} )
    end
  end
end
