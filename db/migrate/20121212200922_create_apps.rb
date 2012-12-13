class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.text :name

      t.timestamps
    end
  end
end
