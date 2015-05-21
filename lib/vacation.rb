class Vacation < ActiveRecord::Base
  belongs_to :specialist



  def unavailable_dates

  end

private

  def date_range
    range = self.start_date - self.end_date
  end


end
