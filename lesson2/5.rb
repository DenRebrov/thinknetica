months = [31,28,31,30,31,30,31,31,30,31,30,31]

def leap_year?(year)
  return true if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
end

puts "Введите день (число от 1 до 31)"
day = gets.to_i

puts "Введите месяц (число от 1 до 12)"
month = gets.to_i

puts "Введите год (число от 1 до 9999)"
year = gets.to_i

day = months[month - 1] if day > months[month - 1]
month = 12 if month > 12

date_number = months.take(month).inject(0){ |sum, elem| sum + elem }
date_number = date_number - (months[month - 1] - day)
date_number += 1 if leap_year?(year) && date_number > 59

puts "Порядковый номер даты (кол-во дней): #{date_number}"
