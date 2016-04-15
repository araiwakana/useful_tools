require './constants'
require File.expand_path(File.dirname(__FILE__) + '/../../network/httpd/base')
require 'json'
module BackLog
  class Base 
    def self.http_get(path, params = {} )
      params.merge!(BackLog::Constants::API_TOKEN)
      uri = BackLog::Constants::ENDPOINT + "/" + path
      Network::Http::Get.new( uri, params ).connect
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
