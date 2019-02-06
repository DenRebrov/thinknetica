class PassengerWagon < Wagon
  validate :total_volume, :max, 60

  def fill_volume(_volume)
    super(1)
  end

  def to_s
    'Пассажирский вагон. Число свободных мест: ' \
      "#{available_volume} шт. (#{@occupied_volume} шт. занятых)"
  end
end
