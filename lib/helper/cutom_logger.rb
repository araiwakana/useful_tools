require 'logger'
module CustomLogger
  def write_log(level:, content:, path:)
    begin
      log = Logger.new(path)
      log.send(level.to_s, content)
    rescue => e
      p e
    end
  end
end