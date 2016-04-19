require './base'
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
      mile_stones = mile_stones_infos.map do |mile_stones_info|
         BackLog::MileStone.new( id: mile_stones_info[:id],
                                 project_id: mile_stones_info[:projectId],
                                 name: mile_stones_info[:name],
                                 description: mile_stones_info[:description],
                                 start_date: Time.parse( mile_stones_info[:startDate] ),
                                 due_date: Time.parse( mile_stones_info[:releaseDueDate] ),
                                 archived: mile_stones_info[:archived]
                               )
      end
    end

    def self.create
    end

    def update
    end

    def delete
    end
  end
end
pp BackLog::MileStone.find("TECH_M")
