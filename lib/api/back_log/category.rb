module BackLog
  class Category
    include Converter
    #constants
    ENDPOINT = 'categories'
    
    #accessor
    attr_accessor :id　　　
    #constructor
    def initialize(id:)
      @id = id
    end

    #class method
    def self.all_ids(project_id)
      category_infos = JSON.parse( BackLog::Base.http_get(BackLog::Project::ENDPOINT + "/" + project_id.to_s + "/" + BackLog::Category::ENDPOINT), {:symbolize_names => true} )
      categories = category_infos.map { |category_info| category_info[:id]}
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
