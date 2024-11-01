class CreateSurveys < ActiveRecord::Migration[7.2]
  def change
    create_table :surveys, id: :uuid do |t|
      t.string :feeling, null: false
      t.integer :stress, null: false
      t.text :comments

      t.timestamps
    end
  end
end
