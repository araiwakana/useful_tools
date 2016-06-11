module GoogleDrives
  class Constants
    SETTING = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config.yml'))
    CLIENT_ID = SETTING["client_id"]
    CLIENT_SECRET = SETTING["client_secret"]
    REFRESH_TOKEN = SETTING["refresh_token"]
    ACCESS_TOKEN = SETTING["access_token"]
  end
end