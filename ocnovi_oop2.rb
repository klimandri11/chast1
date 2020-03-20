class Station # класс станция
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

  def type_trains(type) # возвращает список поездов типа type
    self.trains.find_all { |train| train.type == type }
  end

  def type_train_numder(type) # возвращает количество поездов данного типа
    self.trains.count { |train| train.type == type }
  end

end

class Route # класс маршрут
  attr_reader :stations # возвращает список всех станций маршрута

  def initialize(start, finish) # начальная и конечная станция указываются при создании
    @stations = [start, finish] #массив станций
  end

  def first_station # первая станция
    @stations[0]
  end

  def last_station # последняя станция
    @stations[-1]
  end

  def print # выводит список всех станций по-порядку от начальной до конечной
    stations.each{ |st| puts st.name }
  end

  def add_station(station) # добавлении станции в маршрут
    stations.insert(-2,station)
  end

  def delete_station(station) # удалении станции из маршрута
    if station != @stations[0] && station != @stations[-1]
      stations.delete(station)
    end
  end

end

class Train # класс поезд
  attr_reader :speed, :number_trains, :type # возвращать значения скорости, количество вагонов

  def initialize(number, type, number_trains) # предположим, что если грузовой, то пользователь введет type = 'gr', а если пассажирский 'ps'
                                              # указываем при создании номер поезда, тип, количество вагонов
    @number = number
    @type = type
    @number_trains = number_trains
    @speed = 0
  end

  def add # прицепляет вагон
    if @speed == 0
      @number_trains += 1
    end
  end

  def delete # отцепляет вагон
      if @speed == 0 && @number_trains != 0
        @number_trains -= 1
      end
  end

  def stop(value) # сброс скорости до нуля
    if @speed >= value
      @speed -= value
    end
  end

  def gathe(value) # набор скорости
    @speed += value
  end

  def new_route(route) # задание маршрута
    @route = route
    @location_index = 0 # индекс массива stations, нужен для перемещения между станциями, по умолчанию в стартовой станции маршрута
    location.add_trains(self)
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

  def forward # перемещение между станциями вперед
    if next_station
      @location_index += 1
      previous.delete_trains(self)
      location.add_trains(self)
    end
  end

  def back # перемещение между станциями назад
    if previous
      @location_index -= 1
      next_station.delete_trains(self)
      location.add_trains(self)
    end
  end

end
