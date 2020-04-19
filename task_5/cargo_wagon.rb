class CargoWagon < Wagon
  attr_reader :occupied_volume, :free_volume
  def initialize(znach)
    @total_volume = znach
    @occupied_volume = 0
    @free_volume = znach
  end

  def fill_volume(volume)
    if volume <= @free_volume
      @occupied_volume += volume
      @free_volume -= volume 
    end
  end
end
