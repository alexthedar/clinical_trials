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
    schedule_template = self.schedules
    results = []
    conflicts = []
    scheduled_visits = []
    results << conflicts
    results << scheduled_visits

# TODO: Pull out destroy method to be called independently after user cancels schedule_template attempt
# TODO: Create results class with conflict and scheduled_visits as structs within. Can then pass conflict and scheduled_visits messages.

    if available_dates.include?(patient_start_date)
      new_visit = Visit.create(trial_id: id, patient_id: patient.id, schedule_id: schedule_template[0].id, appt_date: patient_start_date)
      scheduled_visits << new_visit
      next_date = patient_start_date + schedule_template[0].days_to_next
      schedule_template.each do |visit_to_schedule|
        unless visit_to_schedule.visit_number == 1
          if available_dates.include?(next_date)
            new_visit = Visit.create(trial_id: id, patient_id: patient.id, schedule_id: visit_to_schedule.id, appt_date: next_date)
            scheduled_visits << new_visit
          else
binding.pry
            if next_date.holiday?(:us)
              holiday_name = next_date.holidays(:us).first.fetch(:name)
              conflicts << ["Visit #{visit_to_schedule.visit_number} has a conflict on #{next_date}", "#{next_date} is #{holiday_name}", next_date]
            elsif next_date.weekend?
              conflicts << ["Visit #{visit_to_schedule.visit_number} has a conflict on #{next_date}", "#{next_date} is a weekend", next_date]
            elsif next_date > self.end_date
              conflicts << ["Visit #{visit_to_schedule.visit_number} has a conflict on #{next_date}", "#{next_date} is outside trial window", next_date]
            else
              conflicts << ["Visit #{visit_to_schedule.visit_number} has a conflict on #{next_date}", "#{next_date} is another patient visit", next_date]
            end
          end
          next_date += visit_to_schedule.days_to_next
        end
      end
    else
      if patient_start_date.holiday?(:us)
        holiday_name = patient_start_date.holidays(:us).first.fetch(:name)
        conflicts << ["Visit 1 has a conflict on #{patient_start_date}", "#{patient_start_date} is #{holiday_name}", patient_start_date]
      elsif patient_start_date.weekend?
        conflicts << ["Visit 1 has a conflict on #{patient_start_date}", "#{patient_start_date} is a weekend", patient_start_date]
      else
        conflicts << ["Visit 1 has a conflict on #{patient_start_date}", "#{patient_start_date} is another patient visit", patient_start_date]
      end
    end
    if conflicts.any?
      visits.each do |visit|
        if visit.appt_date && visit.patient_id == patient.id
          visits.delete(visit.id)
          Visit.delete(visit.id)
        end
      end
      results[1] = []
    end
    results
  end

private
  def upcase
    self.name = name.titlecase
    self.company = company.titlecase
  end
end
