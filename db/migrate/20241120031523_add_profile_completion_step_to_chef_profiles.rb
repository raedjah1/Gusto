class AddProfileCompletionStepToChefProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :chef_profiles, :profile_completion_step, :integer, default: 0
  end
end
