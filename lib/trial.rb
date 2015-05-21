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

private
  def upcase
    self.name = name.titlecase
    self.company = company.titlecase
  end
end
