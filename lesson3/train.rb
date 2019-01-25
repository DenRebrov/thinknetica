class Train
  attr_reader :wagons_count, :speed, :current_station,
    :number, :type, :route

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
  end

  def raise_speed(change_speed)
    @speed += change_speed
  end

  def stop
    @speed = 0
  end

  def hook_wagon
    @wagons_count += 1 if speed == 0
  end

  def unhook_wagon
    @wagons_count -= 1 if speed == 0 && @wagons_count > 0
  end

  def set_route(route)
    @route = route
    @current_station = 0
    @route.stations[@current_station].add_train(self)
  end

  def move_forward
    if next_station
      @route.stations[@current_station].send_train(self)
      @route.stations[@current_station + 1].add_train(self)
      @current_station += 1
    end
  end

  def move_backwards
    if previous_station
      @route.stations[@current_station].send_train(self)
      @route.stations[@current_station - 1].add_train(self)
      @current_station -= 1
    end
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station > 0
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def current_station
    @route.stations[@current_station]
  end
end
