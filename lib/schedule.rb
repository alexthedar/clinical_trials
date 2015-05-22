class Schedule < ActiveRecord::Base
  belongs_to :trial
  has_many :visits
  has_many :patients, through: :visits
  has_many :specialists, through: :visits

  def delete_schedule(trial_id, visit_number)
    Schedule.delete("visit_number = #{visit_number} AND trial_id = #{trial_id}")
  end


end
