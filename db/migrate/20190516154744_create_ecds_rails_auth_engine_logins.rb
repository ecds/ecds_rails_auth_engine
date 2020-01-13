# frozen_string_literal: true

#
# Migration for the engine
#
class CreateEcdsRailsAuthEngineLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :ecds_rails_auth_engine_logins do |t|
      t.string :who
      t.string :token
      t.string :provider

      t.references :user, primary_key_options(:type)

      t.timestamps
    end
  end

  private

  def primary_key_options(option_name)
    EcdsRailsAuthEngine.primary_key_type ? { option_name => EcdsRailsAuthEngine.primary_key_type } : {}
  end
end
