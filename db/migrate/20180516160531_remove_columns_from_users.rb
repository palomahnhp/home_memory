class RemoveColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :public_health_org
    remove_column :users, :public_health_org_url
    remove_column :users, :public_health_membership_number
    remove_column :users, :public_health_autonomic_code
    remove_column :users, :public_health_card_number
    remove_column :users, :private_health_company
    remove_column :users, :private_health_company_url
    remove_column :users, :private_health_card_number
  end
end
