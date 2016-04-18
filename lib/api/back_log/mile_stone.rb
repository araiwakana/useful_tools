module BackLog
  class MileStone
    attr_accessor :id, :project_id, :name, :description, :start_date, :due_date, :archived
    ENDPOINT = "projects"

    def initialize(id:, project_id:, name:, description:, start_date:, due_date:, archived:)
      @id = id
      @project_id = project_id
      @name  = name
      @description = description
      @start_date = start_date
      @due_date = due_date
      @archived = archived
    end

    def self.find(project_id)
      mile_stones_infos = JSON.parse( BackLog::Base.http_get(BackLog::MileStone::ENDPOINT + "/" + project_id.to_s + "/" + "versions") , {:symbolize_names => true} )
      mile_stones = mile_stones_infos.map { |mile_stones_info| BackLog::MileStone.new( mile_stones_info[:id], mile_stones_info[:projectId], mile_stones_info[:name], mile_stones_info[:description], mile_stones_info[:startDate], mile_stones_info[:releaseDueDate], mile_stones_info[:archived]) }
    end

    def self.create
    end

    def update
    end

    def delete
    end
  end
end
