namespace :ukokkei do
  desc "chatwork から google spread sheet へ chat=>起票=>タスク追加 chat=>返信を自動化します"
  task :topics_chat_to_drive  do
    require File.expand_path(File.dirname(__FILE__) + '/projects/ukokkei')
    Ukokkei::Batch.transport
  end
end
namespace :api do
  task :set_all do
    ["chatwork","google_drive","back_log"].each do |api_name|
      Rake::Task["api:#{api_name}:set_default_api_key"].execute
    end
  end
  namespace :chatwork do
    desc "chatworkのapiをデフォルトのkeyに設定します"
    task :set_default_api_key do
      src = File.expand_path(File.dirname(__FILE__) + '/lib/api/chatwork/templete.yml')
      dest = File.expand_path(File.dirname(__FILE__) + '/lib/api/chatwork/config.yml')
      FileUtils.cp(src, dest)
    end
  end
  namespace :google_drive do
    desc "google_driveのapiをデフォルトのkeyに設定します"
    task :set_default_api_key do
      src = File.expand_path(File.dirname(__FILE__) + '/lib/api/google_drives/templete.yml')
      dest = File.expand_path(File.dirname(__FILE__) + '/lib/api/google_drives/config.yml')
      FileUtils.cp(src, dest)
    end
  end
  namespace :back_log do
    desc "back_logのapiをデフォルトのkeyに設定します"
    task :set_default_api_key do
      src = File.expand_path(File.dirname(__FILE__) + '/lib/api/back_log/templete.yml')
      dest = File.expand_path(File.dirname(__FILE__) + '/lib/api/back_log/config.yml')
      FileUtils.cp(src, dest)
    end
  end
end
