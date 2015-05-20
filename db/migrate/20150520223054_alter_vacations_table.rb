class AlterVacationsTable < ActiveRecord::Migration
  def change
    change_table :vacations do |v|
      v.remove :number_of_days
      v.remove :date
      v.string :start_date
      v.string :end_date
    end

  end
end
