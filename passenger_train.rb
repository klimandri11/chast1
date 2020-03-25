class PassengerTrain < Train

  def add(wagon)
    super if wagon.is_a?(PassengerWagon)
  end
end
