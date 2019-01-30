require_relative 'manufacturing_company.rb'
require_relative 'instance_counter.rb'

class Train
  NIL_NUMBER_ERROR = "Номер не может быть пустым"
  INVALID_NUMBER_FORMAT = "Номер имеет неправильный формат. Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис и еще 2 буквы или цифры после дефиса"
  NUMBER_FORMAT = /^[a-zа-яё\d]{3}\-?[a-zа-яё\d]{2}$/i

  include ManufacturingCompany
  include InstanceCounter

  attr_reader :speed, :current_station, :number, :route, :wagons

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@trains[number] = self
    register_instance
  end

  def raise_speed(change_speed)
    @speed += change_speed
  end

  def stop
    @speed = 0
  end

  def hook_wagon(wagon)
    @wagons << wagon if attachable_wagon?(wagon)
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon) if attachable_wagon?(wagon)
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

  def have_wagons?
    self.wagons.size > 0
  end

  def validate?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise NIL_NUMBER_ERROR if number.nil? || number == ""
    raise INVALID_NUMBER_FORMAT if number !~ NUMBER_FORMAT
  end
end
