module ApplicationHelper

  def datetime_to_ptbr date, time
    datetime = "#{date} #{time.strftime("%H:%M:%S")}".to_datetime

    datetime.strftime('%d/%m/%Y %H:%M:%S') if datetime
  end

end
