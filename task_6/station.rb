require_relative 'module_instance_counter'
require_relative 'module_validation'

class Station
  include InstanceCounter
  include Validation
  NAME_FORMAT = /^([a-z]|[а-я])+-?\d?$/i
  attr_reader :trains, :name
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name
    validate!
    @trains = [] # массив поездов
    self.class.all << self
    register_instance
  end

  def station_block(trains = @trains)
    trains.each { |train| yield(train) }
  end

  def self.all
    @all ||= []
  end

  def add_train(train) # принимает поезда по одному за раз
    @trains << train
  end

  def delete_train(train) # отправляет поезда по одному за раз
    @trains.delete(train)
  end

  def type_trains(type) # возвращает список поездов типа type
    trains.find_all { |train| train.type == type }
  end

  def type_train_numder(type) # возвращает количество поездов данного типа
    trains.count { |train| train.type == type }
  end

end
