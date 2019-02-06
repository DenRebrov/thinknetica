class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, VALUE_FORMAT

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end

  def to_s
    "Поезд № #{number}. Пассажирский поезд с #{wagons.size} вагонами"
  end
end
