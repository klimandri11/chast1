class CargoTrain < Train

  validate :number, :format, NUMBER_FORMAT

  def add(wagon)
    super if wagon.is_a?(CargoWagon)
  end
end
