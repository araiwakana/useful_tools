module BackLog
  class Project
    #mix_in
    include Converter
    #constants
    ENDPOINT = 'projects'
    REDIS_KEY = 'projects'
    attr_accessor :id, :name, :key
    #accessor
    def initialize(id ,name, key)
      @id = id
      @name = name
      @key = key
    end

    #class method
    def self.all
      project_infos = JSON.parse( BackLog::Base.http_get(BackLog::Project::ENDPOINT) , {:symbolize_names => true} )
      porjects = project_infos.map { |project_info| BackLog::Project.new( project_info[:id], project_info[:name], project_info[:projectKey] ) }
    end

    def self.find(id)
      projects = self.all
      projects.detect { |project| project.id == id }
    end

    def self.create(name:, key:, chartEnabled: true, subtaskingEnabled: true, textFormattingRule: "markdown" )
      params =  {
                 name: name,
                 key: key,
                 chartEnabled: chartEnabled,
                 subtaskingEnabled: subtaskingEnabled,
                 textFormattingRule: textFormattingRule
                }
      project_info = JSON.parse( BackLog::Base.http_post(BackLog::Project::ENDPOINT, params), {:symbolize_names => true} )
      created_project = BackLog::Project.new( project_info[:id], project_info[:name], projece_info[:projectKey] )
    end
    
    #instance method
    def update(name: self.name, key: self.key, chartEnabled: true, subtaskingEnabled: true, textFormattingRule: "markdown" )
      project_info = JSON.parse( BackLog::Base.http_patch(BackLog::Project::ENDPOINT + "/" + self.id.to_s, params), {:symbolize_names => true})
      updated_project = BackLog::Project.new( project_info[:id], project_info[:name], projece_info[:projectKey] )
    end

    def delete
      JSON.parse( BackLog::Base.http_delete(BackLog::Project::ENDPOINT + "/" + self.id.to_s),  {:symbolize_names => true} )
    end

    def show
      JSON.parse( BackLog::Base.http_get(BackLog::Project::ENDPOINT + "/" + self.id.to_s),  {:symbolize_names => true} )
    end

    def mile_stones
      BackLog::MileStone.find(self.id)
    end

    def types
      BackLog::Type.find_by_project_id(self.id)
    end
  end
end