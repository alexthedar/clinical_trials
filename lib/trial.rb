class Trial < ActiveRecord::Base
  has_many :visits
  has_many :patients, through: :visits
  has_many :specialists, through: :visits
  has_many :schedules

  before_save(:upcase)

  def available_patients
    available_patients = []
    Patient.all.each do |patient|
      unless patient.visits.any?
        available_patients << patient unless self.patients.include?(patient)
      end
    end
    available_patients
  end

  def schedule_patient(patient, patient_start_date)
    trial_cal = Calendar.new(start_date: start_date, end_date: end_date)
    available_dates = trial_cal.available_dates
    schedule = self.schedules
    results = []
    conflicts = []
    scheduled_visits = []
    results << conflicts
    results << scheduled_visits

binding.pry      
    if available_dates.include?(patient_start_date)
      new_visit = Visit.create(trial_id: id, patient_id: patient.id, schedule_id: schedule[0].id, appt_date: patient_start_date)
      scheduled_visits << new_visit
      next_date = patient_start_date + schedule[0].days_to_next
      schedule.each do |visit_to_schedule|
        unless visit_to_schedule.visit_number == 1
          if available_dates.include?(next_date)
            new_visit = Visit.create(trial_id: id, patient_id: patient.id, schedule_id: visit_to_schedule.id, appt_date: next_date)
            scheduled_visits << new_visit
          else
            conflicts << ["Visit #{visit_to_schedule.visit_number} has a conflict on #{next_date}", next_date]
            results[1] = []
            visits.each do |visit|
              if visit.appt_date
                visits.delete(visit.id)
                Visit.delete(visit.id)
              end
            end
          end
          next_date += visit_to_schedule.days_to_next
        end
      end
    else
      conflicts << ["This patient cannot be scheduled on #{patient_start_date}", patient_start_date]
      results[1] = []
      visits.each do |visit|
        if visit.appt_date
          visits.delete(visit.id)
          Visit.delete(visit.id)
        end
      end
    end
    results
  end

private
  def upcase
    self.name = name.titlecase
    self.company = company.titlecase
  end
end
