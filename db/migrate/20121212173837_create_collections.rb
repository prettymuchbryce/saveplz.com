class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.text :name
      t.integer :current_id, :default => 0
      t.integer :app_id
      t.timestamps
    end
  end
end
