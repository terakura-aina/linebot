class CreateMakePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :make_plans do |t|
      t.references :inviter, foreign_key: { to_table: :users }
      t.references :partner, foreign_key: { to_table: :users }
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
