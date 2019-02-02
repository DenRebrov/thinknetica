class Railway
  SELECT_TRAIN = 'Выбери порядковый номер поезда из списка'
  SELECT_WAGON = 'Выбери порядковый номер вагона из списка'
  SELECT_ROUTE = 'Выбери порядковый номер маршрута из списка'
  SELECT_STATION = 'Выбери порядковый номер станции из списка'
  SELECT_TYPE = 'Укажи тип (1 - cargo / 2 - passenger)'
  WAGON_ON = 'Вагон прицеплен!'
  WAGON_OFF = 'Вагон НЕ прицеплен. Разные типы поезда и вагона'
  TRAIN_CURRENT_STATION = 'Поезд прибыл на станцию '
  TRAIN_END_STATION = 'Поезд на конечной станции'
  STATION_EMPTY = 'На этой станции нет поездов'
  NOT_ENOUGH_STATIONS = 'Недостаточно станций!'
  NOT_ENOUGH_ROUTES = 'Нужно создать маршрут!'
  NOT_ENOUGH_TRAINS = 'Нужно создать поезд!'
  NOT_ENOUGH_WAGONS = 'Нужно создать вагон!'
  NOT_ENOUGH_WAGONS_TO_TRAIN = 'У поезда нет прицепленных вагонов!'
  NOT_ENOUGH_SPACE = 'Недостаточно места в вагоне!'
  ADD_STATION = 'Создана станция: '
  ADD_TRAIN = 'Создан поезд: '
  ADD_WAGON = 'Создан вагон: '
  ADD_VOLUME = 'Введи объем, который хочешь заполнить от 1 до '
  ADD_ROUTE = 'Создан маршрут: '
  SET_TRAIN_NUMBER = 'Введи номер поезда'
  SET_SEATS = 'Введи кол-во мест в вагоне (от 1 до 60 место)'
  SET_TOTAL_VOLUME = 'Введи общий объем грузового вагона (от 0 до 80 м3)'
  SET_STATION_NAME = 'Введи название станции'
  SET_STATION_NUMBER = [
    'Введи порядковый номер начальной станции из списка',
    'Введи порядковый номер конечной станции из списка'
  ]

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
    puts ADD_STATION + "#{station.name}"
    sleep 1

  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    puts SET_TRAIN_NUMBER
    number = gets.chomp

    puts SELECT_TYPE
    train_type = select_from_array([CargoTrain, PassengerTrain])

    train = train_type.new(number)
    @trains << train
    puts ADD_TRAIN + "#{train.to_s}"
    sleep 1

  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    return puts(NOT_ENOUGH_STATIONS) if @stations.size < 2

    puts SET_STATION_NUMBER[0]
    show_array(@stations, :name)
    ini_station = select_from_array(@stations)

    puts SET_STATION_NUMBER[1]
    show_array(@stations, :name)
    end_station = select_from_array(@stations)

    route = Route.new(ini_station, end_station)
    @routes << route
    puts ADD_ROUTE + "#{route.to_s}"
    sleep 1

  rescue RuntimeError => e
    puts e.message
    retry
  end

  def assign_route
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_TRAIN
    show_array(@trains, :to_s)
    train = select_from_array(@trains)

    puts SELECT_ROUTE
    show_array(@routes, :to_s)
    route = select_from_array(@routes)

    train.set_route(route)
  end

  def add_station
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_STATION
    show_array(@stations, :name)
    station = select_from_array(@stations)

    puts SELECT_ROUTE
    show_array(@routes, :to_s)
    route = select_from_array(@routes)

    route.add_station(station)
    @stations.delete(station)
  end

  def remove_station
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_ROUTE
    show_array(@routes, :to_s)
    route = select_from_array(@routes)

    puts SELECT_STATION
    show_array(route.stations, :name)
    station = select_from_array(route.stations)

    route.delete_station(station)
    @stations.push(station)
  end

  def create_wagon
    puts SELECT_TYPE
    wagon_type = select_from_array([CargoWagon, PassengerWagon])
    begin
      if wagon_type == PassengerWagon
        puts SET_SEATS
        content = gets.to_i
      else
        puts SET_TOTAL_VOLUME
        content = gets.to_f
      end
      wagon = wagon_type.new(content)
      @wagons << wagon
      puts ADD_WAGON + "#{wagon.to_s}"

    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  def hook_wagon
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_WAGONS) if @wagons.empty?

    puts SELECT_TRAIN
    show_array(@trains, :to_s)
    train = select_from_array(@trains)

    puts SELECT_WAGON
    show_array(@wagons, :to_s)
    wagon = select_from_array(@wagons)

    if train.hook_wagon(wagon)
      @wagons.delete(wagon)
      puts WAGON_ON
    else
      puts WAGON_OFF
    end
  end

  def unhook_wagon
    train_with_wagons = @trains.select(&:have_wagons?)

    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_WAGONS_TO_TRAIN) if train_with_wagons.size.zero?

    puts SELECT_TRAIN
    show_array(train_with_wagons, :to_s)
    train = select_from_array(train_with_wagons)

    puts SELECT_WAGON
    show_array(train.wagons, :to_s)
    wagon = select_from_array(train.wagons)
    unhooked_wagon = train.unhook_wagon(wagon)
    @wagons << unhooked_wagon unless unhooked_wagon.nil?
  end

  def fill_part_wagon
    return puts(NOT_ENOUGH_WAGONS) if @wagons.empty?

    puts SELECT_WAGON
    show_array(@wagons, :to_s)
    wagon = select_from_array(@wagons)

    if wagon.is_a?(CargoWagon)
      puts ADD_VOLUME + "#{wagon.available_volume} м3"
      volume = gets.to_f
    end

    if wagon.fill_volume(volume)
      puts wagon.to_s
      sleep 1
    else
      puts NOT_ENOUGH_SPACE
      sleep 1
    end
  end

  def train_forward
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_TRAIN
    show_array(@trains, :to_s)
    train = select_from_array(@trains)

    if train.move_forward
      puts TRAIN_CURRENT_STATION + train.current_station.name
    else
      puts TRAIN_END_STATION
    end
  end

  def train_backwards
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?
    return puts(NOT_ENOUGH_ROUTES) if @routes.empty?

    puts SELECT_TRAIN
    show_array(@trains, :to_s)
    train = select_from_array(@trains)

    if train.move_backwards
      puts TRAIN_CURRENT_STATION + train.current_station.name
    else
      puts TRAIN_END_STATION
    end
  end

  def stations_list
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?

    @stations.each do |station|
      puts "На станции #{station.name}:" if station.have_trains?
      station.each_train do |train|
        puts train
        train.each_wagon { |wagon| puts wagon }
        puts
      end
    end
  end

  def trains_list
    return puts(NOT_ENOUGH_STATIONS) if @stations.empty?
    return puts(NOT_ENOUGH_TRAINS) if @trains.empty?

    puts SELECT_STATION
    show_array(@stations, :name)
    station = select_from_array(@stations)

    if station.trains.empty?
      puts STATION_EMPTY
    else
      station.trains.each { |train| puts train.to_s }
    end
  end

  private

  def show_array(array, name_method = :name)
    array.each.with_index(1) do |item, index|
      puts "#{index}. #{item.send(name_method)}"
    end
  end

  def select_from_array(array)
    user_input = gets.to_i
    user_input = gets.to_i until user_input.between?(1, array.size)
    array[user_input - 1]
  end
end
