class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.date   :born_date
      t.string :document
      t.string :public_health_org
      t.string :public_health_org_url
      t.string :public_health_membership_number
      t.string :public_health_autonomic_code
      t.string :public_health_card_number
      t.string :private_health_company
      t.string :private_health_company_url
      t.string :private_health_card_number

      t.timestamps
    end
  end
end
