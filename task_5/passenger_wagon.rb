class PassengerWagon < Wagon

  def add_seat
    if @occupied < @total
      @occupied += 1
    end
  end

end
