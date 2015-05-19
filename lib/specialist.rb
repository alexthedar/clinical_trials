class Specialist < ActiveRecord::Base
  has_many :visits
  has_many :patients, through: :visits
  has_many :trials, through: :visits
  has_many :vacations

  validates(:name, {:presence => true})

  before_save(:upcase)

private
  def upcase
    self.name = name.titlecase
  end
end
