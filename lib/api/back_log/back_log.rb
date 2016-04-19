#ruby標準添付ライブラリ
require 'json'
require 'yaml'
require 'pp'
require 'time'

#bundlerでinstallしたgemをすべてrequire
require 'bundler'
Bundler.require

#自作のhttpd
require File.expand_path(File.dirname(__FILE__) + '/../../network/httpd/base')

#他のクラス(読み込む順番大事)
require './constants'
require './base'

require './project'
require './mile_stone'
require './task'
require './type'
require './user'

module BackLog

end



# pp BackLog::Project.all
p project = BackLog::Project.find(61072)
# p project.mile_stones
p project.types