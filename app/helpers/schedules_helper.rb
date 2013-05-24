module SchedulesHelper
  
  #[2011/08/25 DZF]: here I set the name of the days
  def set_day_name_by_day_id(day_id)
    d = Day.find(day_id)
    if d.day_number == 1
      return "Lunes"
    elsif d.day_number == 2
      return "Martes"
    elsif d.day_number == 3
      return "Miercoles"
    elsif d.day_number == 4
      return "Jueves"
    elsif d.day_number == 5
      return "Viernes"
    elsif d.day_number == 6
      return "Sabado"
    elsif d.day_number == 7
      return "Domingo"
    else
      return "Undefined"
    end
  end
  
  def set_day_name_by_day_number(day_number)
    if day_number == 1
      return "Lunes"
    elsif day_number == 2
      return "Martes"
    elsif day_number == 3
      return "Miercoles"
    elsif day_number == 4
      return "Jueves"
    elsif day_number == 5
      return "Viernes"
    elsif day_number == 6
      return "Sabado"
    elsif day_number == 7
      return "Domingo"
    else
      return "Undefined"
    end
  end
end
