class Railway
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def create_station
    puts "Введи название станции"
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
      #check_choice(ini_station, @stations)
      until (ini_station <= @stations.size) && (ini_station > 0)
        ini_station = gets.to_i
      end

      puts "Введи номер конечной станции из списка"
      @stations.each.with_index(1) do |station, index|
        puts "#{index}. #{station.name}"
      end
      end_station = gets.to_i
      #check_choice(end_station, @stations)
      until (end_station <= @stations.size) && (end_station > 0)
        end_station = gets.to_i
      end

      route = Route.new(@stations[ini_station - 1], @stations[end_station - 1])
      @routes << route
    end
  end

  def assign_route
    if @trains.empty? || @routes.empty?
      create_train if @trains.empty?
      create_route if @routes.empty?
      assign_route
    else
      puts "Выбери поезд из списка и нажми соответствующую цифру"
      @trains.each.with_index(1) do |train, index|
        puts "#{index}. Поезд № #{train.number} / #{train.type}"
      end
      train = gets.to_i
      #check_choice(train, @trains)
      until (train <= @trains.size) && (train > 0)
        train = gets.to_i
      end

      puts "Выбери маршрут из списка и нажми соответствующую цифру"
      @routes.each.with_index(1) do |route, index|
        puts "#{index}. #{route.stations}"
      end
      route = gets.to_i
      #check_choice(route, @routes)
      until (route <= @routes.size) && (route > 0)
        route = gets.to_i
      end

      @trains[train - 1].set_route(@routes[route - 1])
    end
  end

  def create_wagon
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
    @wagons << wagon
  end

  def hook_wagon
    if @trains.empty? || @wagons.empty?
      create_train if @trains.empty?
      create_wagon if @wagons.empty?
      hook_wagon
    else
      puts "Выбери поезд из списка к которому будешь прицеплять вагоны"
      @trains.each.with_index(1) do |train, index|
        puts "#{index}. Поезд № #{train.number} / #{train.type}"
      end
      train = gets.to_i
      #check_choice(train, @trains)
      until (train <= @trains.size) && (train > 0)
        train = gets.to_i
      end

      puts "Выбери вагон из списка, который будешь прицеплять"
      @wagons.each.with_index(1) do |wagon, index|
        puts "#{index}. #{wagon.type}"
      end
      wagon = gets.to_i
      #check_choice(wagon, @wagons)
      until (wagon <= @wagons.size) && (wagon > 0)
        wagon = gets.to_i
      end

      if @trains[train - 1].hook_wagon(@wagons[wagon - 1])
        @wagons.delete(@wagons[wagon - 1])
        puts "Вагон прицеплен!"
      else
        puts "Вагон НЕ прицеплен. Разные типы поезда и вагона"
      end
    end
  end

  def unhook_wagon
    if @trains.empty? || @trains.select { |train| train.have_wagons? } == nil

      puts "Сначала создай поезд!" if @trains.empty?
      puts "Сначала прицепи вагон к поезду" if @trains.select { |train| train.have_wagons? } == nil
    else
      train_with_wagons = @trains.select { |train| train.have_wagons? }

      train_with_wagons.each.with_index(1) do |wagon, index|
        puts "#{index}. Поезд № #{wagon.number} / #{wagon.type}"
        @wagon_type = wagon.type
      end
      wagon = gets.to_i
      until (wagon <= train_with_wagons.size) && (wagon > 0)
        wagon = gets.to_i
      end

      @trains.each do |train|
        train.wagons.delete(@wagons[wagon - 1]) if train.wagons.size > 0
      end

      if @wagon_type == :cargo
        wagon = CargoVagon.new(@wagon_type)
      else
        wagon = PassengerVagon.new(@wagon_type)
      end
      @wagons.push(wagon)
    end
  end

  def train_forward
    if @trains.empty? || @routes.empty?
      create_train if @trains.empty?
      create_route if @routes.empty?
      assign_route
      train_forward
    else
      puts "Выбери поезд из списка и нажми соответствующую цифру"
      @trains.each.with_index(1) do |train, index|
        puts "#{index}. Поезд № #{train.number} / #{train.type}"
      end
      train = gets.to_i
      until (train <= @trains.size) && (train > 0)
        train = gets.to_i
      end

      if @trains[train - 1].move_forward
        puts "Поезд прибыл на станцию #{@trains[train - 1].current_station.name}"
      else
        puts "Поезд на конечной станции"
      end
    end
  end

  def train_backwards
    if @trains.empty? || @routes.empty?
      create_train if @trains.empty?
      create_route if @routes.empty?
      assign_route
      train_forward
    else
      puts "Выбери поезд из списка и нажми соответствующую цифру"
      @trains.each.with_index(1) do |train, index|
        puts "#{index}. Поезд № #{train.number} / #{train.type}"
      end
      train = gets.to_i
      until (train <= @trains.size) && (train > 0)
        train = gets.to_i
      end

      if @trains[train - 1].move_backwards
        puts "Поезд прибыл на станцию #{@trains[train - 1].current_station.name}"
      else
        puts "Поезд на конечной станции"
      end
    end
  end

  def stations_list
    if @stations.empty? || @routes.empty?
      create_station if @stations.empty?
      create_route if @routes.empty?
      assign_route
      stations_list
    else
      puts "Выбери маршрут из списка и нажми соответствующую цифру"
      @routes.each.with_index(1) do |route, index|
        puts "#{index}. #{route.stations}"
      end
      route = gets.to_i
      #check_choice(route, @routes)
      until (route <= @routes.size) && (route > 0)
        route = gets.to_i
      end

      @routes[route - 1].stations.each do |station|
        puts station
      end
    end
  end

  def trains_list
    if stations.empty? || @trains.empty?
      create_station if @stations.empty?
      create_train if @trains.empty?
      trains_list
    else
      puts "Введи порядковый номер станции из списка"
      @stations.each.with_index(1) do |station, index|
        puts "#{index}. #{station.name}"
      end

      station = gets.to_i
      #check_choice(ini_station, @stations)
      until (station <= @stations.size) && (station > 0)
        station = gets.to_i
      end

      if @stations[station - 1].trains.empty?
        puts "На данной станции нет поездов"
      else
        @stations[station - 1].trains.each { |train| puts train.number }
      end
    end
  end

private

  #def show_elements(array, attribute)
  #  array.each_with_index do |elem, index|
  #    puts "#{index + 1}. #{elem.attribute}"
  #  end
  #end


  # Метод не используется в главном файле
  # private, а не protected, потому что у данного класса нет потомков
  #def check_choice(user_input, array)
  #  until (user_input <= array.size) && (user_input > 0)
  #    user_input = gets.to_i
  #  end
  #  user_input
  #end
end
