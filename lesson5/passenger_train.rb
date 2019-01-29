class PassengerTrain < Train
  def initialize(number, type)
    super(number, 2)
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end

  def to_s
    "Поезд № #{self.number}. Пассажирский поезд с #{self.wagons.size} вагонами"
  end
end
