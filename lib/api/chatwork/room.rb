module ChatWork
  class Room < ChatWork::Base
    include ChatWork::Custom

    @@end_point = ChatWork::Constants::BASE_URL + "/rooms"

    attr_accessor :room_id, :msgs

    def initialize(room_id:)
      set_base_point
      @room_id = room_id
      msgs = Array.new
    end
    def get_my_rooms#自分のチャット一覧の取得
      JSON.parse( http_get(base_end_point), {:symbolize_names => true} )
    end
    def create_new_room(params)#グループチャットを新規作成
     JSON.parse( http_post(base_end_point, {:data =>params} ), {:symbolize_names => true} )
    end
    def change_room(room_id, params)#チャットの名前、アイコンをアップデート
      JSON.parse( http_put(base_end_point + "/#{room_id}", params ), {:symbolize_names => true} )
    end
    def delete_room(room_id)#グループチャットを削除する
      JSON.parse( http_delete(base_end_point + "/#{room_id}", {:data =>  {:action_type => "delete"}} ), {:symbolize_names => true} )
    end
    def leave_room(room_id)#グループチャットを退席する
      JSON.parse( http_delete(base_end_point + "/#{room_id}", {:action_type => "leave"} ), {:symbolize_names => true} )
    end
    def get_members_of_room#チャットのメンバー一覧を取得
      JSON.parse( http_get(base_end_point + "/#{room_id}" + "/members"), {:symbolize_names => true} )
    end
    def update_member_of_room#チャットのメンバーを一括変更
      JSON.parse( http_put(base_end_point + "/#{room_id}" + "/members", params), {:symbolize_names => true} )
    end
    def get_latest_100s_mgs(force: false)#チャットのメッセージ一覧を取得。パラメータ未指定だと前回取得分からの差分のみを返します。(最大100件まで取得)
      begin
        messages_info = JSON.parse( http_get(base_end_point + "/#{room_id}" + "/messages", {:force => force ? 1 :0} ), {:symbolize_names => true} )
        @msgs = messages_info.map {|msg_info| ChatWork::Message.new(
                                                            id: msg_info[:message_id],
                                                            account_id: msg_info[:account][:account_id],
                                                            account_name: msg_info[:account][:name],
                                                            body: msg_info[:body])
                          }
      rescue TypeError => e
        msgs = Array.new
        self
      end
    end
    def send_chat(params)#チャットを送る
      p params
      JSON.parse( http_post(base_end_point + "/#{room_id}/messages" , {:body =>params[:body]} ), {:symbolize_names => true} )
    end
    def get_msg_info#メッセージ情報を取得
    end
    def get_tasks_of_room#チャットのタスク一覧を取得 (※100件まで取得可能
    end
    def make_task(params)#チャットに新しいタスクを追加
      JSON.parse( http_post(base_end_point + "/#{room_id}" + "/tasks",{body: params[:body], to_ids: params[:ids].join(","), limit: params[:limit]}),
                  {:symbolize_names => true}
                )
    end
    def get_task_info#タスク情報を取得
    end
    def get_file_info#ファイル情報を取得
    end
  end
end
