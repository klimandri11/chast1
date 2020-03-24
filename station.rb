class Station
  attr_reader :trains, :name # возвращает список поездов, находящися на станции

  def initialize(name_station) # имя станции указывается при создании
    @name = name_station
    @trains = [] # массив поездов
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
