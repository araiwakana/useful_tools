module BackLog
  class Constants
    ENDPOINT = "https://temona.backlog.jp/api/v2"
    SETTING = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config.yml'))
    API_TOKEN = {apiKey: SETTING["api_key"]}
  end
end
