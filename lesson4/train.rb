class Train
  attr_reader :speed, :current_station, :number,
    :type, :route, :wagons

  def initialize(number, type)
    @number = number
    @speed = 0
    @type = type
    @wagons = []
  end

  def raise_speed(change_speed)
    @speed += change_speed
  end

  def stop
    @speed = 0
  end

  def hook_wagon(wagon)
    @wagons << wagon if same_type?(wagon)
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon) if same_type?(wagon) && !@wagons.empty?
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

  protected

  # Метод инкапсулирован, потому что не используется в интерфейсе класса
  # protected, потому что у данного класса будут дочерние
  def same_type?(wagon)
    self.type == wagon.type
  end

  def have_wagons?
    self.wagons.size > 0
  end
end
