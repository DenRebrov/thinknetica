require_relative 'instance_counter.rb'
require_relative 'accessors.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation
  extend Acсessors

  attr_accessor_with_history :name, :trains

  validate :name, :presence

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

  def trains?
    trains.size > 0
  end
end
