require File.expand_path(File.dirname(__FILE__) + "/lib/api/back_log/back_log.rb")

all_users = BackLog::User::TECH_M_USERS
category_ids = BackLog::Category.all_ids(61072)

team_kpi = 0
all_tasks = BackLog::Task.get_all_task(61072, 4, category_ids, all_users);
all_tasks.each do |task|
  kpi = task.calculate_kpi
  team_kpi = team_kpi + kpi
end
array1 = []
array1 << team_kpi
# ファイルへ書き込み
CSV.open("team_kpi.csv", "wb") do |csv|
  csv << [Date.today.to_s] + array1 
end

p "=============================================="

array2 = Array.new
category_ids.each do |category_id|
  team_kpi = 0
  tasks_by_category = BackLog::Task.get_all_task(61072, 4, category_id, all_users);
  tasks_by_category. each do |task|
    kpi = task.calculate_kpi 
    team_kpi = team_kpi + kpi
  end
array2.push(team_kpi)  
end
# ファイルへ書き込み
CSV.open("category_kpi.csv", "wb") do |csv|
  csv << [Date.today.to_s] + array2
end
p "==============================================="
 
array3 = Array.new
all_users.each do |user_id|
  personal_kpi = 0
  tasks_by_assignee = BackLog::Task.get_all_task(61072, 4, category_ids, user_id);
  tasks_by_assignee.each do |task|
    kpi = task.calculate_kpi
    personal_kpi = kpi + personal_kpi
  end
array3.push(personal_kpi)  
end
# ファイルへ書き込み
CSV.open("personal_kpi.csv", "wb") do |csv|
  csv << [Date.today.to_s] + array3
end

 p "==============================================="



