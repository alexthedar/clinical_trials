class AddStartDateEndDateToTrialTable < ActiveRecord::Migration
  def change
    add_column(:trials, :start_date, :date)
    add_column(:trials, :end_date, :date)
  end
end
