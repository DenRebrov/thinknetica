require_relative 'instance_counter.rb'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(initial_station, end_station)
    @stations = [initial_station, end_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def show_stations(stations)
    @stations.each { |station| puts station.name }
  end

  def to_s
    new_stations = @stations.map { |station| station.name }
    new_stations.delete_at(0)
    new_stations.delete_at(-1)
    [@stations.first.name, new_stations, @stations.last.name].join(' > ')
  end
end
