require_relative 'instance_counter.rb'

class Station
  NIL_NAME_ERROR = 'Название станции не может быть пустым'
  NAME_TOO_LENGTH_ERROR = 'Слишком длинное название, не больше 30 символов'

  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.is_a?(type) }
  end

  def send_train(train)
    trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def have_trains?
    trains.size > 0
  end

  def validate?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise NIL_NAME_ERROR if name.nil? || name == ''
    raise NAME_TOO_LENGTH_ERROR if name.length > 30
  end
end
