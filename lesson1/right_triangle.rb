def equilateral?(a, b, c)
  return true if a == b && a == c && b == c
end

def isosceles?(a, b, c)
  return true if a == b || a == c || b == c
end

def rectangular?(a, b, c)
  return true if c**2 == a**2 + b**2
end

triangle_sides = []

puts "Введите длину первой стороны треугольника"
triangle_sides << gets.to_f

puts "Введите длину второй стороны треугольника"
triangle_sides << gets.to_f

puts "Введите длину третьей стороны треугольника"
triangle_sides << gets.to_f

triangle_sides.sort!

if rectangular?(*triangle_sides) &&
 isosceles?(*triangle_sides)
  puts "Трелугольник прямоугольный и равнобедренный!"
elsif rectangular?(*triangle_sides)
  puts "Трелугольник прямоугольный!"
elsif equilateral?(*triangle_sides)
  puts "Трелугольник равнобедренный и равносторонний, но НЕ прямоугольный"
else
  puts "Трелугольник НЕ прямоугольный"
end
