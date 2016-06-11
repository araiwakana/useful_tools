module ChatWork
  class Constants
    SETTING = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config.yml'))
    API_TOKEN = SETTING["api_key"]
    BASE_URL = SETTING["end_point"]
  end
end