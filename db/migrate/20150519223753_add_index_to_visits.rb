class AddIndexToVisits < ActiveRecord::Migration
  def change
    add_index :visits, :trial_id
    add_index :visits, :patient_id
    add_index :visits, :specialist_id
    add_index :visits, :schedule_id

  end
end
