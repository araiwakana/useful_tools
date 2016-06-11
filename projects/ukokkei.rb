require File.expand_path(File.dirname(__FILE__) + '/../lib/api/base')
require File.expand_path(File.dirname(__FILE__) + '/../lib/helper/cutom_logger')

module Ukokkei
  module Presenter
    def render_task(topic_number)
      "課題表#{topic_number}に回答\nhttps://docs.google.com/spreadsheets/d/1PsdaetcZgvjqz1vd47xRqsaJn8VFJBsR7F9i1oJsq3M/edit#gid=775159406"
    end
    def invalid_update_msg(msg)
      "[To:#{msg.account_id}]\n課題表#{msg.topic_number}は未作成か、バッチがまだ動いてません。"
    end
  end
  module Logger
    include CustomLogger
    def log(level, content)
      write_log(level: level, content: content, path: File.expand_path(File.dirname(__FILE__) + '/../logs/ukokkei'))
    end
  end
  class Batch
    extend Ukokkei::Presenter
    extend Ukokkei::Logger
    ROOMS = {ukokkei: 49530621, design: 35892021}
    SPREAD_SHEET_KEY = "1PsdaetcZgvjqz1vd47xRqsaJn8VFJBsR7F9i1oJsq3M"
    WORK_SHEET_ID = 775159406
    STATUS = {not_yet: "未了", in_process: "処理中", done: "処理済", completed: "完了"}

    def self.transport
      ROOMS.each do |room_name, room_id|
        log(:info, "exporting #{room_name.to_s}")
        export_topics_chat_work_to_drive(room_id)
      end
    end
    def self.export_topics_chat_work_to_drive(room_id)
      @room = ChatWork::Room.new(room_id: room_id)
      @room.get_latest_100s_mgs
      container = @room.split_by_topic
      @drive_client = GoogleDrives::Base.new
      @spreadsheet = @drive_client.session.spreadsheet_by_key(SPREAD_SHEET_KEY)
      @work_sheet = @spreadsheet.worksheet_by_gid(WORK_SHEET_ID)
      list = @work_sheet.list
      current_low_num = @work_sheet.rows.find_index {|row| row[1..-1].uniq.sort.last == ""} - 1
      today = Time.now.strftime("%Y/%m/%d")
      int_now = Time.now.to_i
      rows = @work_sheet.rows
      container.each do |key, msgs|
        case key
          when :new
            msgs.each do |msg|
              list[current_low_num] = {"No" => current_low_num+2, "記入日" => today, "記入者" => msg.account_name, "内容" => msg.body, "ステータス" => STATUS[:not_yet], "担当" => msg.to[:ids].empty? ? "" : msg.to[:names].join(",")}
              @room.make_task(body: render_task(current_low_num+2), ids: msg.to[:ids], limit: int_now) unless msg.to[:ids].empty?
              current_low_num += 1
            end
          when :reply
            msgs.each do |msg|
              list_judge = rows.detect {|row| row.first == msg.topic_number.to_s && row.uniq.size >= 3}
              unless list_judge
                @room.send_chat( body: invalid_update_msg(msg) )
              else
                list_row = list[ rows.index(list_judge) - 1 ]
                list_row["回答内容"] = list_row["回答内容"] + "\n\n" + msg.body + msg.signature
              end
            end
          when :status
        end
      end
      @work_sheet.save
    rescue => e
      log(:error, "#{e.class.to_s}\n#{e.message}")
    end
  end
end