require './base'
module BackLog
  class User
    ENDPOINT = 'users'
    def self.all
      JSON.parse( BackLog::Base.http_get(BackLog::User::ENDPOINT) )
    end
  end
end


#test
p BackLog::User.all
