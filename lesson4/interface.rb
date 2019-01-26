class Interface
  attr_reader :stations, :trains, :routes

def initialize
  @stations = []
  @trains = []
  @routes = []
end

def create_station
  puts "Введите название станции"
  name = gets.chomp
  station = Station.new(name)
  @stations << station
end

def create_train
  puts "Введи номер поезда"
  number = gets.to_i

  puts "Укажи тип поезда (cargo / passenger)"
  type = gets.chomp.to_sym

  until type == :cargo || type == :passenger
    puts "Укажи тип поезда (cargo / passenger)"
    type = gets.chomp.to_sym
  end

  if type == :cargo
    train = CargoTrain.new(number, type)
  else
    train = PassengerTrain.new(number, type)
  end
  @trains << train
end

def create_route
  if @stations.size < 2
    create_station
    create_route
  else
    puts "Введи номер начальной станции из списка"
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
    ini_station = gets.to_i
    check_choice(ini_station, @stations)

    puts "Введи номер конечной станции из списка"
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
    end_station = gets.to_i
    check_choice(end_station, @stations)

    route = Route.new(@stations[ini_station - 1], @stations[end_station - 1])
    @routes << route
  end
end

def assign_route
  if @trains.empty? && @routes.empty?
    create_train if @trains.empty?
    create_route if @routes.empty?
    assign_route
  else
    puts "Выберите номер поезда из списка и нажмите соответствующую цифру"
    @trains.each.with_index(1) do |train, index|
      puts "#{index}. #{train.number}"
    end
    train = gets.to_i
    check_choice(train, @trains)

    puts "Выберите номер маршрута из списка и нажмите соответствующую цифру"
    @routes.each.with_index(1) do |route, index|
      puts "#{index}. #{route.stations}"
    end
    route = gets.to_i
    check_choice(route, @routes)

    @trains[train - 1].set_route(@routes[route - 1])
  end

  def create_vagon
    puts "Укажи тип вагона (cargo / passenger)"
    type = gets.chomp.to_sym

    until type == :cargo || type == :passenger
      puts "Укажи тип вагона (cargo / passenger)"
      type = gets.chomp.to_sym
    end

    if type == :cargo
      wagon = CargoVagon.new(type)
    else
      wagon = PassengerVagon.new(type)
    end
  end

  def hook_vagon
    if @trains.empty?
      create_train
      hook_vagon
    else

    end

    hook_wagon(wagon)
  end













end

private





  def show_elements(array, attribute)
    array.each_with_index do |elem, index|
      puts "#{index + 1}. #{elem.attribute}"
    end
  end


  # Метод не используется в главном файле
  # private, а не protected, потому что у данного класса нет потомков
  def check_choice(user_input, array)
    until (user_input <= array.size) && (user_input > 0)
      user_input = gets.to_i
    end
  end

end
