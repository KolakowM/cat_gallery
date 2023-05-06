class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :title
      t.text :content
      t.boolean :publicznosc

      t.timestamps
    end
  end
end
