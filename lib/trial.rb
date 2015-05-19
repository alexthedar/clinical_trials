class Trial < ActiveRecord::Base
  has_many :visits
  has_many :patients, through: :visits
  has_many :specialists, through: :visits
  has_one :schedule

  before_save(:upcase)

private
  def upcase
    self.name = name.titlecase
    self.company = company.titlecase
  end
end
