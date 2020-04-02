class CargoTrain < Train

  def add(wagon)
    super if wagon.is_a?(CargoWagon)
  end
end
