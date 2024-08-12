module DatetimeHelper
  def minutes_between(start_time, end_time)
    ((end_time - start_time) * 24 * 60).to_i
  end
end
