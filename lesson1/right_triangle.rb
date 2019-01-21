def is_isosceles?(a, b, c)
  return true if a == b || a == c || b == c
end

def is_right?(a, b, c)
  return true if c**2 == a**2 + b**2
end

triangle_sides = []

puts "Введите длину первой стороны треугольника"
triangle_sides << gets.chomp.to_f

puts "Введите длину второй стороны треугольника"
triangle_sides << gets.chomp.to_f

puts "Введите длину третьей стороны треугольника"
triangle_sides << gets.chomp.to_f

triangle_sides.sort!

if is_right?(triangle_sides[0], triangle_sides[1], triangle_sides[2]) &&
 is_isosceles?(triangle_sides[0], triangle_sides[1], triangle_sides[2])
  puts "Трелугольник прямоугольный и равнобедренный!"
elsif is_right?(triangle_sides[0], triangle_sides[1], triangle_sides[2])
  puts "Трелугольник прямоугольный!"
else
  puts "Трелугольник НЕ прямоугольный"
end
