class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.text :data
      t.integer :record_id
      t.integer :collection_id

      t.timestamps
    end
  end
end
