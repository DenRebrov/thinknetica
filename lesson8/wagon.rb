class Wagon
  NIL_NAME_ERROR = 'Значение не может быть пустым'

  attr_reader :total_volume, :occupied_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @occupied_volume = 0
    @available_volume = @total_volume
    validate!
  end

  def fill_volume(volume)
    return if available_volume < volume
    @occupied_volume += volume
  end

  def available_volume
    @total_volume - @occupied_volume
  end

  def validate?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise NIL_NAME_ERROR if total_volume.nil? || total_volume == ''
  end
end
