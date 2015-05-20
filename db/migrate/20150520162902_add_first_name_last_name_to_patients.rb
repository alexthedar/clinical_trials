class AddFirstNameLastNameToPatients < ActiveRecord::Migration
  def change
    change_table :patients do |t|
      t.remove :name
      t.string :first_name
      t.string :last_name
    end
  end
end
