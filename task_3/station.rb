require_relative 'module_instance_counter'

class Station
  attr_reader :trains, :name
  include InstanceCounter

  def initialize(name_station)
    @name = name_station
    @trains = [] # массив поездов
    self.class.all << self
    register_instance
  end

  def add_train(train) # принимает поезда по одному за раз
    @trains << train
  end

  def delete_train(train) # отправляет поезда по одному за раз
    @trains.delete(train)
  end

 #Нигде уже не используются
  def type_trains(type) # возвращает список поездов типа type
    trains.find_all { |train| train.type == type }
  end

  def type_train_numder(type) # возвращает количество поездов данного типа
    trains.count { |train| train.type == type }
  end
end
