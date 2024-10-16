# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.2]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      # Skip adding `email` and `encrypted_password` since they already exist
      # t.string :email,              null: false, default: ""
      # t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      # Skip adding `reset_password_sent_at` and `reset_password_token` since they already exist
      # t.string   :reset_password_token
      # t.datetime :reset_password_sent_at

      ## Rememberable
      # Skip adding `remember_created_at` since it already exists
      # t.datetime :remember_created_at

      ## Trackable
      # Uncomment if needed in the future
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # Uncomment if you plan to use confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # Uncomment if you plan to use lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    # Skip adding the index on email since it already exists
    # add_index :users, :email, unique: true

    # Skip adding the index on reset_password_token since it already exists
    # add_index :users, :reset_password_token, unique: true

    # Uncomment these lines if you want to use confirmable or lockable
    # add_index :users, :confirmation_token, unique: true
    # add_index :users, :unlock_token, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
