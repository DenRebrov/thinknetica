class CargoTrain < Train
  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end

  def to_s
    "Поезд № #{self.number}. Грузовой поезд с #{self.wagons.size} вагонами"
  end
end
