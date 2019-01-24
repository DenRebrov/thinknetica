class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def show_trains
    trains.each { |train| puts train}
  end

  def show_trains_type
    trains.each { |train| puts train.type}
  end

  def send_train(train)
    trains.delete(train)
  end
end
