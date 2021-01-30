class CreateMakePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :make_plans do |t|
      t.integer :invited_id
      t.integer :partner_id
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
    add_index :make_plans, :invited_id
    add_index :make_plans, :partner_id
  end
end
