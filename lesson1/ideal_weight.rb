puts "Введите ваше имя"
name = gets.chomp.capitalize

puts "Введите ваш рост"
height = gets.to_i

ideal_weight = height - 110

if ideal_weight >= 0
  puts "#{name}, ваш идеальный вес должен быть #{ideal_weight} кг"
else
  puts "Ваш вес уже оптимальный"
end
