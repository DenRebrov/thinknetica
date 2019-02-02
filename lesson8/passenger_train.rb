class PassengerTrain < Train
  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end

  def to_s
    "Поезд № #{number}. Пассажирский поезд с #{wagons.size} вагонами"
  end
end
