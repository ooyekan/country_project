class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :capital
      t.string :region
      t.string :languages
      t.string :currency
      t.string :maps
      t.string :timezones
      t.string :continents
      t.string :flags

      t.timestamps
    end
  end
end
