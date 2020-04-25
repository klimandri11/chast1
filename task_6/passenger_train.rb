class PassengerTrain < Train

  validate :number, :format, NUMBER_FORMAT

  def add(wagon)
    super if wagon.is_a?(PassengerWagon)
  end
end
