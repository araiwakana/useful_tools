module BackLog
  class Type
    #mix_in
    include Converter
    #constants
    ENDPOINT = 'projects'
    REDIS_KEY = 'types'
    @@redis = Redis.new
    @@redis_expire_sec = 60 * 60#1h
    #accessor
    attr_accessor :id, :name, :project_id
    #constructor
    def initialize(id:, name:, project_id:)
      @id = id
      @name = name
      @project_id = project_id
    end

    #class method
    def self.all
      all_types = []
      projects = BackLog::Project.all
      projects.each do |project|
        key = (project.id.to_s + ":" + REDIS_KEY)
        unless @@redis.exists( key )
          find_by_project_id(project.id).each {|type| @@redis.rpush key, type.to_hash.to_json }
          @@redis.expire key, @@redis_expire_sec
        end
        types = (@@redis.lrange key, 0, -1).map do |type_json|
          type_info = JSON.parse( type_json, {:symbolize_names => true} )
          BackLog::Type.new(id: type_info[:id], name: type_info[:name], project_id: type_info[:projectId])
        end
        all_types << types
      end
      return all_types.flatten
    end

    def self.find(type_id)
      all.detect { |type| type.id == type_id }
    end

    def self.find_by_project_id(project_id)
      type_infos = JSON.parse( BackLog::Base.http_get(BackLog::Type::ENDPOINT + "/" + project_id.to_s + "/" + "issueTypes") , {:symbolize_names => true} )
      types = type_infos.map do |type_info|
        BackLog::Type.new(id: type_info[:id], name: type_info[:name], project_id: type_info[:projectId])
      end
    end

    def self.create()
    end

    #instance method
    def update()
    end

    def delete
    end

    def show
    end
  end
end
