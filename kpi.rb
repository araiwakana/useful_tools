require File.expand_path(File.dirname(__FILE__) + "/lib/api/back_log/back_log.rb")

BackLog::Task.show_team_kpi(BackLog::User::TECH_M_USERS, BackLog::Category.all_ids(61072))

BackLog::Task.show_category_kpi(BackLog::User::TECH_M_USERS, BackLog::Category.all_ids(61072))

BackLog::Task.show_personal_kpi(BackLog::User::TECH_M_USERS, BackLog::Category.all_ids(61072))


