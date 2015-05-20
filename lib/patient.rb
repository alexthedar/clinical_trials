class Patient < ActiveRecord::Base
  has_many :visits
  has_one :schedule, through: :visits
  has_many :specialists, through: :visits
  has_one :trial, through: :visits
  validates :first_name, { presence: true, uniqueness: { case_sensitive: false } }
  validates :last_name, { presence: true, uniqueness: { case_sensitive: false } }
  before_save :titleize_name

  def name
    name = "#{last_name}, #{first_name}"
  end

private
  def titleize_name
# binding.pry
    self.first_name = first_name.downcase.titleize
    self.last_name = last_name.downcase.titleize
  end
end
