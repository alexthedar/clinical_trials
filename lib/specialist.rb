class Specialist < ActiveRecord::Base
  has_many :visits
  has_many :patients, through: :visits
  has_many :trials, through: :visits
  has_many :vacations
  validates :first_name, { presence: true, uniqueness: { case_sensitive: false } }
  validates :last_name, { presence: true, uniqueness: { case_sensitive: false } }
  before_save :upcase


  def name
    name = "#{last_name}, #{first_name}"
  end

  before_save(:upcase)

private
  def upcase
    self.first_name = first_name.downcase.titleize
    self.last_name = last_name.downcase.titleize
  end
end
