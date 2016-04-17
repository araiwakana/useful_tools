module Network
  module Http
    class Base
      require 'uri'
      require 'net/http'
      require 'openssl'
      require File.expand_path(File.dirname(__FILE__) + '/get')
      require File.expand_path(File.dirname(__FILE__) + '/post')
      require File.expand_path(File.dirname(__FILE__) + '/patch')
      require File.expand_path(File.dirname(__FILE__) + '/delete')
    end
  end
end
