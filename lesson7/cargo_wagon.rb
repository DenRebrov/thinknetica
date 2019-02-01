class CargoWagon < Wagon
  OUT_OF_MAX = "Слишком много объема, не больше 80 м3"

  def to_s
    "Грузовой вагон с доступным объемом: #{self.available_volume} м3 (#{@occupied_volume} м3 занято)"
  end

  protected

  def validate!
    super
    raise OUT_OF_MAX if @total_volume > 80
  end
end
