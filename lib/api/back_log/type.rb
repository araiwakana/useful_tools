require './base'
module BackLog
  class Type
    ENDPOINT = 'projects'
   attr_accessor :id, :name, :project_id
    def initialize(id:, name:, project_id:)
      @id = id
      @name = name
      @project_id = project_id
    end

    def self.find(project_id)
      type_infos = JSON.parse( BackLog::Base.http_get(BackLog::Type::ENDPOINT + "/" + project_id.to_s + "/" + "issueTypes") , {:symbolize_names => true} )
      types = type_infos.map do |type_info|
        BackLog::Type.new(id: type_info[:id], name: type_info[:name],project_id: type_info[:projectId])
      end
    end

    def self.create()
    end

    def update()
    end

    def delete
    end

    def show
    end
  end
end
