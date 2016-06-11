module GoogleDrives
  class Base
    attr_accessor :session
    def initialize
      client =  OAuth2::Client.new(
        GoogleDrives::Constants::CLIENT_ID, GoogleDrives::Constants::CLIENT_SECRET,
        :site => "https://accounts.google.com",
        :token_url => "/o/oauth2/token",
        :authorize_url => "/o/oauth2/auth"
      )
      auth_token = OAuth2::AccessToken.from_hash(client, { :refresh_token => GoogleDrives::Constants::REFRESH_TOKEN, :expires_at => 3600 })
      auth_token = auth_token.refresh! if auth_token.expired?
      @session = GoogleDrive.login_with_oauth(auth_token.token)
    end
  end

  class SpreadSheet < Base
    def initialize(client, key)
    end
  end
end