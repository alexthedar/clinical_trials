class Patient < ActiveRecord::Base
  has_many :visits
  has_one :schedule, through: :visits
  has_many :specialists, through: :visits
  has_one :trial, through: :visits
  validates :name, { presence: true, uniqueness: { case_sensitive: false } }
  before_save :titleize_name

private
  def titleize_name
    self.name = name.downcase.titleize
  end

end
