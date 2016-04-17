require './constants'
require File.expand_path(File.dirname(__FILE__) + '/../../network/httpd/base')
require 'json'
module BackLog
  class Base 
    def self.http_get( path, params = {} )
      params.merge!( BackLog::Constants::API_TOKEN )
      uri = BackLog::Constants::ENDPOINT + "/" + path
      Network::Http::Get.new( uri, params ).connect
    end
    def self.http_post( path, params = {} )
      params.merge!( query_parameter: BackLog::Constants::API_TOKEN )
      uri = BackLog::Constants::ENDPOINT + "/" + path
      Network::Http::Post.new( uri, params ).connect
    end
    def self.http_put
      Network::Http::Put.new(uri).connect
    end
    def self.http_delete( path, params = {})
      params.merge!( query_parameter: BackLog::Constants::API_TOKEN )
      uri = BackLog::Constants::ENDPOINT + "/" + path
      Network::Http::Delete.new( uri, params ).connect
    end
    def self.http_patch( path, params = {} )
      params.merge!( query_parameter: BackLog::Constants::API_TOKEN )
      uri = BackLog::Constants::ENDPOINT + "/" + path
      Network::Http::Patch.new( uri, params ).connect
    end
  end
end
