class Train
  attr_accessor :wagons_count, :speed, :current_station
  attr_reader :number, :type

  def initialize(registration_number, type, wagons_count)
    @registration_number = registration_number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
  end

  def raise_speed(change_speed)
    self.speed += 1
  end

  def to_brake
    self.speed = 0
  end

  def hitching_wagon
    self.wagons_count += 1 if speed == 0
  end

  def unhooking_wagon
    self.wagons_count -= 1 if speed == 0 && wagons_count > 1
  end

  def set_route(route)
    route.stations[0].add_train(self)
    @current_station = 0
  end

  def move_forward(route, current_station)
    stations = route.stations
    if stations.size > self.current_station + 1
      stations[self.current_station].send_train(self)
      stations[self.current_station + 1].add_train(self)
      self.current_station += 1
    end
  end

  def move_backwards(route, current_station)
    if self.current_station > 0
      stations = route.stations
      stations[self.current_station].send_train(self)
      stations[self.current_station - 1].add_train(self)
      self.current_station -= 1
    end
  end

  def get_previous_station
    stations = route.stations
    stations[self.current_station - 1] if self.current_station > 0
  end

  def get_next_station
    stations = route.stations
    stations[self.current_station + 1] if stations.size > self.current_station + 1
  end
end
