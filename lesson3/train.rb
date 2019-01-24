class Train
  attr_accessor :registration_number, :type
  attr_reader :number_of_wagons, :speed

  def initialize(registration_number, type, number_of_wagons)
    @registration_number = registration_number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def raise_speed
    self.speed += 1
  end

  def to_brake
    self.speed = 0
  end

  def hitching_wagon # прицеплять вагон
    self.number_of_wagons += 1 if speed == 0
  end

  def unhooking_wagon # отцеплять вагон
    self.number_of_wagons -= 1 if speed == 0 && number_of_wagons > 1
  end

  def itinerary(route) # маршрут следования
    route.stations[0].add_train(self) # station.add_train(self)
  end

  def moving_to_station(route, station, direction = "forward")
    if direction == "forward"
      route.stations[station] += 1
    else
      route.stations[station] -= 1
    end
  end

  def show_stations(route, station)
    #if station.trains.include?(self)
      three_stations = [
        route.stations[station] -= 1,
        route.stations[station],
        route.stations[station] += 1
      ]
  end
end
