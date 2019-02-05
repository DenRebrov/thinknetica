class CargoTrain < Train
  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end

  def to_s
    "Поезд № #{number}. Грузовой поезд с #{wagons.size} вагонами"
  end
end
