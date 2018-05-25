#
# Create the users table
#
class CreateEcdsAuthEngineUsers < ActiveRecord::Migration[5.1]
  create_table :users do |t|
    t.string :display_name
    t.belongs_to :login, index: { unique: true }, foreign_key: true
    t.timestamps
  end
end
