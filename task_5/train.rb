require_relative 'module_manufacturer'
require_relative 'module_instance_counter'
NUMBER_FORMAT = /^(\d|[a-z]|[а-я]){3}-?(\d|[a-z]|[а-я]){2}$/

class Train
  attr_reader :speed, :number, :wagons
  include Manufacturer
  include InstanceCounter

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    self.class.hash_trains[number] = self
    register_instance
  end

  def train_block (wagons = @wagons) # передаю блок в классе interface строки 213 и 219
    wagons.each { |wagon| yield(wagon) }
  end

  def self.hash_trains
    @@hash_trains ||= {}
  end

  def self.find(number)
    @@hash_trains[number]
  end

  def add(wagon) # прицепляет вагон
    if @speed == 0
      @wagons << wagon
    end
  end

  def delete(wagon) # отцепляет вагон
    if @speed == 0 && @wagons.length != 0
      @wagons.delete(wagon)
    end
  end

  def stop(value)
    if @speed >= value
      @speed -= value
    end
  end

  def gathe(value)
    @speed += value
  end

  def new_route(route)
    @route = route
    @location_index = 0 # индекс массива stations, нужен для перемещения между станциями, по умолчанию в стартовой станции маршрута
    location.add_train(self)
  end

  def forward # перемещение между станциями вперед
    if next_station
      @location_index += 1
      previous.delete_train(self)
      location.add_train(self)
    end
  end

  def back # перемещение между станциями назад
    if previous
      @location_index -= 1
      next_station.delete_train(self)
      location.add_train(self)
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected
  def validate!
    raise "Неверный формат номера" if number !~ NUMBER_FORMAT
    raise "Такой номер уже существует" if self.class.hash_trains.key?(number)
  end

  def location # возвращает текущую станцию поезда
    @route.stations[@location_index]
  end

  def previous # возвращает предыдущую станцию
    if location != @route.first_station
      @route.stations[@location_index - 1]
    end
  end

  def next_station # возвращает след станцию
    if location != @route.last_station
      @route.stations[@location_index + 1]
    end
  end
end
