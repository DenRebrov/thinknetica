puts "Введите основание треугольника"
basis = gets.chomp.to_f

puts "Введите высоту треугольника"
height = gets.chomp.to_f

area = basis / 2 * height

puts area.round(2)
