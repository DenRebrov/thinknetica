cart = {}
sum = 0

loop do
  puts "Введите название товара (чтобы закончить ввод, введите 'stop')"
  product_name = gets.chomp
  break if product_name.downcase == 'стоп'

  puts "Введите цену товара за единицу"
  price = gets.to_f

  puts "Введите кол-во купленного товара"
  quantity = gets.to_f

  cart[product_name] = { price: price, quantity: quantity }
  sum += price * quantity
end

puts "Вы купили:"

cart.each do |key, value|
  puts "#{key} за #{value[:price]} в кол-ве #{value[:quantity]}"
end

puts "Итоговая сумма за все товары: #{sum}"
