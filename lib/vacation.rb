class Vacation < ActiveRecord::Base
  belongs_to :specialist



  def unavailable_dates

  end



  # def date_range
  #   days =[]
  #   range = self.end_date - self.start_date
  #   date.push[start_date]
  #   for range.each do |date|
  #     date.push[start_date + date]
  # end


end
