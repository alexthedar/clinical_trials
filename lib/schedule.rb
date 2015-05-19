class Schedule < ActiveRecord::Base
  belongs_to :trial
  has_and_belongs_to_many :visits
end
