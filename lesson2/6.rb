cart = {}
sum = 0

loop do
  puts "Введите название товара (чтобы закончить ввод, введите 'stop')"
  product_name = gets.chomp
  break if product_name.downcase == 'stop'

  puts "Введите цену товара за единицу"
  price = gets.to_f

  puts "Введите кол-во купленного товара"
  quantity = gets.to_f

  cart[product_name] = { price: price, quantity: quantity }
end

puts "Вы купили:"

cart.each do |product_name, product_info|
  puts "#{product_name} за #{product_info[:price]} в кол-ве #{product_info[:quantity]} шт."
  sum += product_info[:price] * product_info[:quantity]
end

puts "Итоговая сумма за все товары: #{sum}"
