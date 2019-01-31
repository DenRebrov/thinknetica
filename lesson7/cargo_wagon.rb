class CargoWagon < Wagon
  NIL_NAME_ERROR = "Кол-во объема не может быть пустым"
  NAME_TOO_LENGTH_ERROR = "Слишком много объема, не больше 80 м3"

  attr_reader :total_volume, :occupied_volume, :available_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @occupied_volume = 0
    @available_volume = @total_volume
    validate!
  end

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

  def validate?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise NIL_NAME_ERROR if @total_volume.nil? || @total_volume == ""
    raise NAME_TOO_LENGTH_ERROR if @total_volume > 80
  end
end
