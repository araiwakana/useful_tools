module BackLog
  class User
    #constants
    ENDPOINT = 'users'
    # when someone take a part in the project, please put the userid here. 
    TECH_M_USERS = [25032, 25027, 27410, 25028, 81683, 25030, 63195, 146687, 146686, 138557, 138613, 152325]
    #accessor
    attr_accessor :id, :name, :mail, :role_id
    #constructor
    def initialize(id , name, mail, role_id )
      @id = id
      @name = name
      @mail = mail
      @role_id = role_id
    end

    #class method
    def self.all
      users_infos = JSON.parse( BackLog::Base.http_get(BackLog::User::ENDPOINT) , {:symbolize_names => true} )
      users = users_infos.map { |user_info| BackLog::User.new( user_info[:id], user_info[:name], user_info[:mailAddress], user_info[:roleType] ) }
    end

    def self.find(id)
      users = self.all
      users.detect { |user| user.id == id }
    end

    def self.create( user_id:, password:, name:, mail:, role_id: )
      params =  {
                 userId: user_id,
                 password: password,
                 name: name,
                 mailAddress: mail,
                 roleType: role_id
                }
      user_info = JSON.parse( BackLog::Base.http_post(BackLog::User::ENDPOINT, params), {:symbolize_names => true} )
      created_user = BackLog::User.new( user_info[:id], user_info[:name], user_info[:mailkAddress], user_info[:roleType] )
    end

    #instance method
    def update( password: nil, name: self.name, mail: self.mail, role_id: self.role_id )
      params =  {
                 password: password,
                 name: name,
                 mailAddress: mail,
                 roleType: role_id
                }
      params.delete(:password) if password.nil?
      user_info = JSON.parse( BackLog::Base.http_patch(BackLog::User::ENDPOINT + "/" + self.id.to_s, params), {:symbolize_names => true})
      BackLog::User.new( user_info[:id], user_info[:name], user_info[:mailkAddress], user_info[:roleType] )
    end

    def delete
      JSON.parse( BackLog::Base.http_delete(BackLog::User::ENDPOINT + "/" + self.id.to_s),  {:symbolize_names => true} )
    end

    def show
      JSON.parse( BackLog::Base.http_get(BackLog::User::ENDPOINT + "/" + self.id.to_s),  {:symbolize_names => true} )
    end
  end
end