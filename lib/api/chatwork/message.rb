module ChatWork
  class Message
    attr_accessor :id, :account_id, :account_name, :body, :to, :topic_number
    def initialize(id:, account_id:, account_name:, body:)
      @id = id
      @account_id = account_id
      @account_name = account_name.gsub(/[^一-龠々]/, "")
      @body = body
      @to = {
        ids: body.scan(/\To:\d*\]/).map {|text| text.gsub(/\D/, "").to_i},
        names: body.scan(/To.*?[一-龠々]*\w*さん/).map {|text| text.gsub(/[^一-龠々]/, "")}
      }
    end
    def set_topic_number
      @topic_number = body.scan(/reply.*\d+/).first.gsub(/\D/,"").to_i
    end
    def trim
      @body = body.split("topic").last.strip.gsub(/^\d+/,"").lstrip
    end
    def signature
      "\nWriten by #{account_name} at #{Time.now.to_s}"
    end
  end
end
