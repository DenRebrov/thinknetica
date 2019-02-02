require_relative 'instance_counter.rb'

class Route
  STATION_OBJECT_ERROR = 'Начальная или конечная станция не является объектом класса \'Station\''
  SAME_STATIONS_ERROR = 'Начальная и конечная станции одинаковы'

  include InstanceCounter

  attr_reader :stations

  def initialize(initial_station, end_station)
    @stations = [initial_station, end_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def to_s
    new_stations = @stations.map(&:name)
    new_stations.delete_at(0)
    new_stations.delete_at(-1)
    [@stations.first.name, new_stations, @stations.last.name].join(' > ')
  end

  def validate?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise STATION_OBJECT_ERROR unless stations.first.is_a?(Station) || stations.last.is_a?(Station)
    raise SAME_STATIONS_ERROR if stations.first == stations.last
  end
end
