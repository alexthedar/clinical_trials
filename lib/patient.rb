class Patient < ActiveRecord::Base
  has_many :visits
  has_one :schedule, through: :visits
  has_many :specialists, through: :visits
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> specialist
  has_one :trial, through: :visits
  validates :name, { presence: true, uniqueness: { case_sensitive: false } }
  before_save :titleize_name

private
  def titleize_name
    self.name = name.downcase.titleize
  end
<<<<<<< HEAD
=======

>>>>>>> 0b2622d165ecc35866d6781f4b575e8698d304f9
>>>>>>> specialist
end
