class CreateEcdsRailsAuthEngineTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :ecds_rails_auth_engine_tokens do |t|
      t.string :token
      t.bigint :login_id
      t.timestamps
    end

    remove_column :ecds_rails_auth_engine_logins, :token
  end
end
