class CargoWagon < Wagon

  def fill_volume(volume)
    if volume <= free
      @occupied += volume
    end
  end
end
