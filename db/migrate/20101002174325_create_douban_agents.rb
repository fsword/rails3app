class CreateDoubanAgents < ActiveRecord::Migration
  def self.up
    create_table :douban_agents do |t|
      t.integer :user_id
      t.string :request_key
      t.string :request_secret
      t.string :access_key
      t.string :access_secret

      t.timestamps
    end
  end

  def self.down
    drop_table :douban_agents
  end
end
