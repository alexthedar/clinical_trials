class Patient < ActiveRecord::Base
  has_and_belongs_to_many :visits
end
