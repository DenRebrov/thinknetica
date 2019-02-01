class CargoWagon < Wagon
  OUT_OF_MAX = "Слишком много объема, не больше 80 м3"

  def fill_volume(volume)
    if volume <= @available_volume
      @occupied_volume += volume
      @available_volume = @total_volume - @occupied_volume
    end
    @occupied_volume
  end

  def to_s
    "Грузовой вагон с доступным объемом: #{@available_volume} м3 (#{@occupied_volume} м3 занято)"
  end

  protected

  def validate!
    super
    raise OUT_OF_MAX if @total_volume > 80
  end
end
