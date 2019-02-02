class PassengerWagon < Wagon
  OUT_OF_MAX = 'Много мест, не больше 60 шт.'

  def fill_volume(volume)
    super(1)
  end

  def to_s
    'Пассажирский вагон. Число свободных мест: ' +
    "#{self.available_volume} шт. (#{@occupied_volume} шт. занятых)"
  end

  protected

  def validate!
    super
    raise OUT_OF_MAX if total_volume > 60
  end
end
