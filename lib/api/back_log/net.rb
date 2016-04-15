require './constants'
module BackLog
  class Net 
    def self.http_get(uri, params)
      Network::Http::Get.new(uri).connect
    end
    def self.http_post
      Network::Http::Post.new(uri).connect
    end
    def self.http_put
      Network::Http::Put.new(uri).connect
    end
    def self.http_delete
      Network::Http::Delete.new(uri).connect
    end
  end
end
