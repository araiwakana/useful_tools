module BackLog
  class Task
    #constants
    ENDPOINT = "issues"
    #accessor
    attr_accessor :id,
                  :name,
                  :assigned_user_id,
                  :created_user_id,
                  :project_id,
                  :mile_stone_id,
                  :parenet_id,
                  :estimated_hour,
                  :created_at,
                  :actual_hour,
                  :start_date,
                  :due_date,
                  :kpi,
                  :type_id,
                  :category_id,
                  :status
    #constructor
    def initialize(id:, name:, assigned_user_id:, created_user_id:, project_id:, mile_stone_id:, parenet_id:, estimated_hour:, actual_hour: ,created_at:, start_date:, due_date:, type_id:, category_id:, status_id:)
      @id = id
      @name = name
      @assigned_user_id = assigned_user_id
      @created_user_id = created_user_id
      @project_id = project_id
      @mile_stone_id = mile_stone_id
      @parenet_id = parenet_id
      @estimated_hour = estimated_hour
      @actual_hour = actual_hour
      @created_at = created_at
      @start_date = start_date.nil? ? Time.now : Time.parse(start_date)
      @due_date = due_date.nil? ? Time.now : Time.parse(due_date)
      @type_id = type_id
      @category_id = category_id
      @status_id = status_id
    end

    #class method
    #look this url what parameters are allowed(http://developer.nulab-inc.com/ja/docs/backlog/api/2/get-issues)
    #parameters hash's keys should be stirng not symbol here
    #the limit of tasks per request is 20(default) to 100, so you migth miss some tasks when the conditions aren't that specific
    def self.get_all_task(project_id, status_id, category_id, user_id)
      @return_all_task = []
      temp_tasks = BackLog::Task.find({"order" => "asc", "projectId[]"=> project_id, "count" => 1})
      temp_tasks.empty? ? start_id = 0 : start_id = temp_tasks[0].return_task_id
      temp_tasks = BackLog::Task.find({"order" => "desc", "projectId[]"=> project_id, "count" => 1})
      temp_tasks.empty? ? end_id = 0 :end_id = temp_tasks[0].return_task_id
      temp_start_id = start_id
      temp_end_id = 0
      temp_offset = 0
      while temp_end_id < end_id
        temp_tasks = BackLog::Task.find({"order" => "asc", "projectId[]"=> project_id, "statusId[]" =>status_id, "categoryId[]"=>category_id, "assigneeId[]" => user_id, "count" => 100, "offset" => temp_offset})
        #pp temp_tasks
        @return_all_task += temp_tasks
        if temp_tasks.length < 100 
          break
        end
        temp_end_id = temp_tasks[temp_tasks.length - 1].return_task_id + 1
        temp_offset += 100 # temp_tasks.length is available as well.        
        sleep(0.01)
      end
      @return_all_task
    end

    def self.find(params)
      params.merge!({order: "asc", count: 100})
      tasks_infos = JSON.parse( BackLog::Base.http_get(BackLog::Task::ENDPOINT, params) , {:symbolize_names => true})
      tasks_infos.map do |task_info|
        BackLog::Task.new(id: task_info[:id],
                          name: task_info[:summary],
                          assigned_user_id: task_info[:assignee].nil? ? 0 : task_info[:assignee][:id],
                          created_user_id: task_info[:createdUser][:id],
                          project_id: task_info[:projectId],
                          mile_stone_id: task_info[:milestone].empty? ? 0 : task_info[:milestone].first[:id],
                          parenet_id: task_info[:parentIssueId].to_i,
                          estimated_hour: task_info[:estimatedHours].to_f,
                          actual_hour: task_info[:actualHours].to_f,
                          created_at: Time.parse(task_info[:created]),
                          start_date: task_info[:startDate],
                          due_date: task_info[:dueDate],
                          type_id: task_info[:issueType][:id],
                          category_id: task_info[:category].empty? ? 0 : task_info[:category].map {|category| category[:id]},
                          status_id: task_info[:status][:id])
      end
    end

    def self.create
    end

    def self.count_number
    end

    #instance method
    def update
    end

    def delete
    end

    def show
    end

# penalty_of_delay should be operated by hand.
    def calculate_kpi
      calclated_kpi = estimated_hour.to_f * self.point_coefficient * self.penalty_of_wrong_expect 
      @kpi = calclated_kpi
    end

    def type
      BackLog::Type.find(self.type_id)
    end

    def point_coefficient
      case type.name
        when "hotfix"
          3.0
        when "bugfix", "調査", "機能改善", "企画", "設計", "開発", "ソースレビュー", "テスト", "デザイン", "UI / UX", "マネジメント", "ディレクション"
          2.5
        when "ルーティーン", "その他"
          1.3
        else
          2.0
      end
    end

    def penalty_of_wrong_expect
      unless estimated_hour.to_i == 0 && actual_hour.to_i == 0
        actual_hour > estimated_hour ? 0.9 : 1
      else
        1
      end
    end

    def return_task_id 
      @task_id = id.to_i
    end

#if you leave "期限日" blank, due_date is gonna be Time.now. It means the time when you get tasks.  So added 60s considering the timelag between calculate_time.
#    def penalty_of_delay( calculate_time )
#      calculate_time > due_date + 60 ? 0.9 : 1
#    end
  end
end
