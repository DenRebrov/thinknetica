class Route
  attr_reader :stations

  def initialize(initial_station, end_station)
    @stations = [initial_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_stations(stations)
    @stations.each { |station| puts station.name }
  end
end
