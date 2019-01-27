class Railway
  SELECT_TRAIN = "Выбери порядковый номер поезда из списка"
  SELECT_WAGON = "Выбери порядковый номер вагона из списка"
  SELECT_ROUTE = "Выбери порядковый номер маршрута из списка"
  SELECT_STATION = "Выбери порядковый номер станции из списка"
  SELECT_TYPE = "Укажи тип (1 - cargo / 2 - passenger)"
  WAGON_ON = "Вагон прицеплен!"
  WAGON_OFF = "Вагон НЕ прицеплен. Разные типы поезда и вагона"
  TRAIN_CURRENT_STATION = "Поезд прибыл на станцию "
  TRAIN_END_STATION = "Поезд на конечной станции"
  STATION_EMPTY = "На этой станции нет поездов"
  NOT_ENOUGH_STATIONS = "Нужно создать хотя бы 2 станции!"
  NOT_ENOUGH_ROUTES = "Нужно создать путь!"
  NOT_ENOUGH_TRAINS = "Нужно создать поезд!"
  NOT_ENOUGH_WAGONS = "Нужно создать вагон!"
  NOT_ENOUGH_WAGONS_TO_TRAIN = "У поезда нет прицепленных вагонов!"
  SET_TRAIN_NUMBER = "Введи номер поезда"
  SET_STATION_NAME = "Введи название станции"
  SET_STATION_NUMBER =
  ["Введи порядковый номер начальной станции из списка",
    "Введи порядковый номер конечной станции из списка"]

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def create_station
    puts SET_STATION_NAME
    name = gets.chomp
    station = Station.new(name)
    @stations << station
  end

  def create_train
    puts SET_TRAIN_NUMBER
    number = gets.to_i

    puts SELECT_TYPE
    type = gets.to_i

    until type == 1 || type == 2
      puts SELECT_TYPE
      type = gets.to_i
    end

    type == 1 ? train = CargoTrain : train = PassengerTrain
    @trains << train.new(number, type)
  end

  def create_route
    return puts(NOT_ENOUGH_STATIONS) if @stations.size < 2

    puts SET_STATION_NUMBER[0]
    select_from_array(@stations, :name)
    ini_station = check_choice(@stations)

    puts SET_STATION_NUMBER[1]
    select_from_array(@stations, :name)
    end_station = check_choice(@stations)

    @routes << Route.new(@stations[ini_station - 1], @stations[end_station - 1])
  end

  def assign_route
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_TRAIN
    select_from_array(@trains, :to_s)
    train = check_choice(@trains)

    puts SELECT_ROUTE
    select_from_array(@routes, :to_s)
    route = check_choice(@routes)

    @trains[train - 1].set_route(@routes[route - 1])
  end

  def create_wagon
    puts SELECT_TYPE
    type = gets.to_i

    until type == 1 || type == 2
      puts SELECT_TYPE
      type = gets.to_i
    end

    type == 1 ? wagon = CargoWagon : wagon = PassengerWagon
    @wagons << wagon.new
  end

  def hook_wagon
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_WAGONS) if @wagons.empty?

    puts SELECT_TRAIN
    select_from_array(@trains, :to_s)
    train = check_choice(@trains)

    puts SELECT_WAGON
    select_from_array(@wagons, :to_s)
    wagon = check_choice(@wagons)

    if @trains[train - 1].hook_wagon(@wagons[wagon - 1])
      @wagons.delete(@wagons[wagon - 1])
      puts WAGON_ON
    else
      puts WAGON_OFF
    end
  end

  def unhook_wagon
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_WAGONS_TO_TRAIN) if @trains.select { |train| train.have_wagons? } == nil

    train_with_wagons = @trains.select { |train| train.have_wagons? }
    select_from_array(train_with_wagons, :to_s)
    wagon = check_choice(train_with_wagons)

    @trains.each do |train|
      @wagon_type = train.wagons[wagon - 1].class
      train.wagons.delete(@wagons[wagon - 1]) if train.wagons.size > 0
    end

    @wagons.push(@wagon_type.new)
  end

  def train_forward
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_TRAIN
    select_from_array(@trains, :to_s)
    train = check_choice(@trains)

    if @trains[train - 1].move_forward
      puts TRAIN_CURRENT_STATION + @trains[train - 1].current_station.name
    else
      puts TRAIN_END_STATION
    end
  end

  def train_backwards
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_TRAIN
    select_from_array(@trains, :to_s)
    train = check_choice(@trains)

    if @trains[train - 1].move_backwards
      puts TRAIN_CURRENT_STATION + @trains[train - 1].current_station.name
    else
      puts TRAIN_END_STATION
    end
  end

  def stations_list
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_ROUTE
    select_from_array(@routes, :to_s)
    route = check_choice(@routes)

    @routes[route - 1].stations.each { |station| puts station.name }
  end

  def trains_list
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?

    puts SELECT_STATION
    select_from_array(@stations, :name)
    station = check_choice(@stations)

    if @stations[station - 1].trains.empty?
      puts STATION_EMPTY
    else
      @stations[station - 1].trains.each { |train| puts train.to_s }
    end
  end

private
  # Метод не используется в главном файле
  # private, а не protected, потому что у данного класса нет потомков
  def select_from_array(array, name_method = :name)
    array.each.with_index(1) do |item, index|
      puts "#{index}. #{item.send(name_method)}"
    end
  end

  # Метод не используется в главном файле
  # private, а не protected, потому что у данного класса нет потомков
  def check_choice(array)
    user_input = gets.to_i
    user_input = gets.to_i until (user_input <= array.size) && (user_input > 0)
    user_input
  end
end
