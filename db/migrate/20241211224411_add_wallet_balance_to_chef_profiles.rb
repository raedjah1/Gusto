class AddWalletBalanceToChefProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :chef_profiles, :wallet_balance, :decimal
  end
end
