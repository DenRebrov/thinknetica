require_relative 'accessors.rb'
require_relative 'validation.rb'

class Wagon
  extend Acсessors
  include Validation

  NIL_NAME_ERROR = 'Значение не может быть пустым'

  #attr_reader :total_volume, :occupied_volume
  attr_accessor_with_history :total_volume, :occupied_volume

  validate :total_volume, :presence

  def initialize(total_volume)
    @total_volume = total_volume
    @occupied_volume = 0
    validate!
  end

  def fill_volume(volume)
    return if available_volume < volume
    @occupied_volume += volume
  end

  def available_volume
    @total_volume - @occupied_volume
  end
end
