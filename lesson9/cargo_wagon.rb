class CargoWagon < Wagon
  validate :total_volume, :max, 80

  def to_s
    "Грузовой вагон с доступным объемом: #{available_volume} м3 (#{occupied_volume} м3 занято)"
  end
end
