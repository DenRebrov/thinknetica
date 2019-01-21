puts "Введите первый (a) коэффициент"
a = gets.to_f

puts "Введите второй (b) коэффициент"
b = gets.to_f

puts "Введите третий (c) коэффициент"
c = gets.to_f

discriminant = b**2 - 4 * a * c

if discriminant > 0
  sqrt = Math.sqrt(discriminant)
  х1 = (-b + sqrt) / (2 * a)
  x2 = (-b - sqrt) / (2 * a)
  puts "Дискриминант = #{discriminant}"
  puts "Первый корень уравнения = #{х1}"
  puts "Второй корень уравнения = #{х2}"
elsif discriminant == 0
  х1 = -b / (2 * a)
  puts "Дискриминант = #{discriminant}"
  puts "Корень уравнения = #{х1}"
else
  puts "Дискриминант = #{discriminant}"
  puts "Корней нет"
end
