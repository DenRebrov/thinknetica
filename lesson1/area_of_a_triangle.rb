puts "Введите основание треугольника"
basis = gets.to_f

puts "Введите высоту треугольника"
height = gets.to_f

area = 0.5 * basis * height

puts area.round(2)
