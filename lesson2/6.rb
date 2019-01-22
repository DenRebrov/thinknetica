result = {}
goods = []
prices = []
quantities = []

loop do
  puts "Введите название товара (чтобы закончить ввод, введите 'stop')"
  goods << gets.chomp

  break if goods.include? "stop"

  puts "Введите цену товара за единицу"
  prices << gets.to_f

  puts "Введите кол-во купленного товара"
  quantities << gets.to_f
end

goods.pop

goods.each do |good|
  prices.each do |price|
    quantities.each do |quantity|
      result[good] = { price => quantity }
    end
  end
end

result.each do |key, value|
  puts "#{key}, #{value}"
end

