
require 'bundler'
Bundler.require
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require File.expand_path(File.dirname(__FILE__) + '/constants')

client = OAuth2::Client.new(
    GoogleDrives::Constants::CLIENT_ID, GoogleDrives::Constants::CLIENT_SECRET,
    :site => "https://accounts.google.com",
    :token_url => "/o/oauth2/token",
    :authorize_url => "/o/oauth2/auth"
)

auth_token = OAuth2::AccessToken.from_hash(client, { :refresh_token => GoogleDrives::Constants::REFRESH_TOKEN, :expires_at => 3600 })
auth_token = auth_token.refresh!


session = GoogleDrive.login_with_oauth(auth_token.token)
a = session
p a
p ws = a.spreadsheet_by_key("1SwxEyCgQc2EvC_OlmA8OYnfdZ0WaHtqPsEqWGcEkmMw").worksheets[0]