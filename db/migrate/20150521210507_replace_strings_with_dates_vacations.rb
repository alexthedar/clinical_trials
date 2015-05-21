class ReplaceStringsWithDatesVacations < ActiveRecord::Migration
  def change
    change_table :vacations do |v|
      v.remove :start_date
      v.remove :end_date
      v.date :start_date
      v.date :end_date
    end

  end
end
