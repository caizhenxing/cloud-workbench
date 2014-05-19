module TimeHelper
  def formatted_time(time, format = :db)
    time.present? ? time.to_formatted_s(format) : '-'
  end

  def same_day(first, second)
    first.beginning_of_day == second.beginning_of_day
  end
end