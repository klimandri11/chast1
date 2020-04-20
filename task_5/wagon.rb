require_relative 'module_manufacturer'
class Wagon
  include Manufacturer
  attr_reader :occupied

  def initialize(znach)
    @total = znach
    @occupied = 0
  end

  def free
    @total - @occupied
  end

  def add_value(value)
    if value <= free
      @occupied += value
    end
  end

end
