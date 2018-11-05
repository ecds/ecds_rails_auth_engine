#
# Create the users table
#
class CreateEcdsRailsAuthEngineUsers < ActiveRecord::Migration[5.1]
  create_table :users do |t|
    t.string :display_name
    t.belongs_to :login, index: { unique: true }, foreign_key: true
    t.timestamps
  end

  def change
    add_column :logins, :confirm_token, :string
  end
end
