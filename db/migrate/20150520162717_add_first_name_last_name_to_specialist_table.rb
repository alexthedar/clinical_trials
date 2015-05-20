class AddFirstNameLastNameToSpecialistTable < ActiveRecord::Migration
  def change
    add_column(:specialists, :first_name, :string)
    add_column(:specialists, :last_name, :string)
    remove_column(:specialists, :name)
  end
end
