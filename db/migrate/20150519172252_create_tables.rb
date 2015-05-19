class CreateTables < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.column :company, :string
      t.column :name, :string
      t.column :number_of_visits, :int
      t.column :description, :string
    end
    create_table :schedules do |s|
      s.column :description, :string
      s.column :visit_number, :int
      s.column :days_to_next, :int
      s.column :trial_id, :int
    end
    create_table :visits do |v|
      v.column :trial_id, :int
      v.column :patient_id, :int
      v.column :specialist_id, :int
      v.column :appt_attended, :boolean
      v.column :schedule_id, :int
      v.column :initial_appt_date, :boolean
      v.column :appt_date, :date
    end
    create_table :patients do |pa|
      pa.column :name, :string
      pa.column :phone, :string
      pa.column :email, :string
      pa.column :gender, :string
      pa.column :birthday, :date
    end
    create_table :specialists do |sp|
      sp.column :name, :string
      sp.column :phone, :string
      sp.column :email, :string
    end
    create_table :vacations do |a|
      a.column :date, :date
      a.column :number_of_days, :int
      a.column :specialist_id, :int
    end
    add_index :vacations, :specialist_id
    add_index :schedules, :trial_id

  end
end
