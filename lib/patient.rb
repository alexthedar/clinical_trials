class Patient < ActiveRecord::Base
  has_many :visits
  has_one :schedule, through: :visits
  has_many :specialists, through: :visits
  has_one :trial, through: :visits
  before_validation :strip_number

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, length: { is: 10 }

  after_validation :convert_number
  before_save :titleize_name
  before_update :stabilize_fields

  def name
    name = "#{last_name}, #{first_name}"
  end

  def strip_number
    self.phone = self.phone.gsub(/([\s()-])/, '')
  end

  def convert_number
    self.phone = "(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..9]}"
  end

private
  def titleize_name
    self.first_name = first_name.downcase.titleize
    self.last_name = last_name.downcase.titleize
  end

  def stabilize_fields


  end
end
