# useful_tools

# ruby version
2.1.4

##how to use


```
gem install bundler
bundle install --path vendor/bundler
```

install redis(mac os)

```
brew install redis
```

##back_log api(http://developer.nulab-inc.com/ja/docs/backlog/auth)


####setting
set your api key at lib/api/back_log/config.yml

####usage

``` ruby
require lib/api/bacK_log.rb
```
then you can user all of back_log api
project/ may be good place to set your progam files

####user
see all users

``` ruby 
BackLog::User.all
```

find user with id = 10
``` ruby
BackLog::User.find(10)
```

####project
add new project
``` ruby
BackLog::Project.create(name: "project name", key: "project key")
```
####type

####mile_stone
calculate kpi of given mile_stone

``` ruby
project = BackLog::Project.find("TECH_M")
project.mile_stones.first.calculate_tasks_kpi
```





