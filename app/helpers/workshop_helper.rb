module WorkshopHelper

  def workshop_schedule(workshop)
    "From #{workshop.start_date} to #{workshop.end_date}"
  end

  def workshop_timings(workshop)
    "At #{workshop.start_time} to #{workshop.end_time} (#{workshop_duration(workshop)})"
  end

  def workshop_duration(workshop)
    "#{((workshop.start_time.to_time - workshop.end_time.to_time)/1.hours).abs} hours"
  end

end