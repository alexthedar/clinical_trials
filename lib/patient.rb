class Patient < ActiveRecord::Base
  has_many :visits
  has_many :specialists, through: :visits
  validates :name, { presence: true, uniqueness: { case_sensitive: false } }
end
