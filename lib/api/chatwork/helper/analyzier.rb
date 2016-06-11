module ChatWork
  module Custom
    KEY_WORD = "topic"
    ACTIONS = ["new","reply","status"]
    STATUSES = ["not_yet", "in_process", "done", "completed"]
    EMPTY_CONTAINER ={:new => [],
                      :reply => [],
                      :status => []
                     }
    def split_by_topic
      return EMPTY_CONTAINER if msgs.nil?
      container = {}
      scoped_topics = msgs.select {|msg| msg.body.index(KEY_WORD)}
      ACTIONS.each do |action|
        unless scoped_topics.any? {|scoped_topic| scoped_topic.body.index(action)}
          container[action.to_sym] = []
          next
        end
        selected_msgs = scoped_topics.select{|msg| msg.body.index(action)}
        container[action.to_sym] = selected_msgs
        selected_msgs.each {|msg| msg.set_topic_number} if action == "reply"
        selected_msgs.each {|msg| msg.trim} if action == "reply" || action == "new"
        scoped_topics = selected_msgs if action == "status"
      end
      unless scoped_topics.empty?
        container[:status] = {}
        STATUSES.each do |status|
          container[:status][status.to_sym] = scoped_topics.select{|msg| msg.body.index(status)}
        end
      end
      container
    end
  end
  module Analyzer
  end
end
