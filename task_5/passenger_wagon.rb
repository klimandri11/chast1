class PassengerWagon < Wagon
  attr_reader :occupied_seats, :free_seats
  def initialize(znach)
    @number_seats = znach
    @occupied_seats = 0
    @free_seats = znach
  end

  def add_seat
    if @occupied_seats < @number_seats
      @occupied_seats += 1
      @free_seats -= 1
    end
  end

end
