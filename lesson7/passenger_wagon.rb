class PassengerWagon < Wagon
  NIL_NAME_ERROR = "Кол-во мест не может быть пустым"
  NAME_TOO_LENGTH_ERROR = "Слишком много мест, не больше 60 мест"

  attr_reader :all_seats, :occupied_seats, :free_seats

  def initialize(all_seats)
    @all_seats = all_seats
    @occupied_seats = 0
    @free_seats = @all_seats
    validate!
  end

  def sit_down
    if @occupied_seats <= @free_seats
      @occupied_seats += 1
      @free_seats = @all_seats - @occupied_seats
    end
    @occupied_seats
  end

  def to_s
    "Пассажирский вагон. Число свободных мест: #{@free_seats} шт. (#{@occupied_seats} шт. занятых)"
  end

  def validate?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise NIL_NAME_ERROR if @all_seats.nil? || @all_seats == ""
    raise NAME_TOO_LENGTH_ERROR if @all_seats > 60
  end
end
