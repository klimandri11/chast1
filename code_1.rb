class Station # класс станция
  attr_reader :trains, :name_station # возвращает список поездов, находящися на станции
  def initialize(name_station) # имя станции указывается при создании
    @name_station = name_station
    @trains = [] # массив поездов
  end
  def add_trains (train) # принимает поезда по одному за раз
    self.trains << train
  end
  def delete_trains (train) # отправляет поезда по одному за раз
    self.trains.delete(train)
  end
  def type_trains # возвращает список поездов на станции по типу: кол-во грузовых, пассажрских
    kol_gr = 0
    kol_ps = 0
    puts "Грузовые: "
    for tr in self.trains
      if tr.type == 'gr'
        kol_gr += 1
        puts tr
      end
    end
    puts "Пассажирские: "
    for tr in self.trains
      if tr.type == 'ps'
        kol_ps += 1
        puts tr
      end
    end
    puts "Количество пассажирских #{kol_ps}"
    puts "Количество грузовых #{kol_gr}"
  end
end

class Route # класс маршрут
  attr_reader :stations, :start, :finish # возвращает список всех станций маршрута
  def initialize (start, finish) # начальная и конечная станция указываются при создании
    @start = start
    @finish = finish
    @stations = [start, finish] #массив станций
  end
  def print # выводит список всех станций по-порядку от начальной до конечной
    puts self.stations
  end
  def add_station(station) # добавлении станции в маршрут
    if station!=self.start and station!=self.finish
      self.stations.insert(-2,station)
    end
  end
  def delete_station (station) # удалении станции из маршрута
    if station!=self.start and station!=self.finish
      self.stations.delete(station)
    end
  end
end

class Train # класс поезд
  attr_accessor :speed, :number_trains, :loc # speed можем задавать сами; возвращать значения скорости, количество вагонов
  attr_reader :type
  def initialize(number, type, number_trains) # предположим, что если грузовой, то пользователь введет type = 'gr', а если пассажирский 'ps'
                                              # указываем при создании номер поезда, тип, количество вагонов
    @number = number
    @type = type
    @number_trains = number_trains
    @speed = 0
    @loc = 0 # индекс массива stations, нужен для перемещения между станциями, по умолчанию в стартовой станции маршрута
  end
  def quantity_change # прицепляет и отцепляет вагоны
    if self.speed == 0
      puts "Выберите цифру: 1-Добавить вагон 2-Отцепить вагон"
      a = gets.to_i
      if a == 1
        self.number_trains += 1
      else
        self.number_trains -= 1
        #self.number_trains - 1
      end
    else
      puts "Действие невозможно, т.к. поезд движется"
    end
  end
  def stop # сброс скорости до нуля
    self.speed = 0
  end
  def new_route(route) # задание маршрута
    @route = route
  end
  def forward # перемещение между станциями вперед
    self.loc += 1
  end
  def back # перемещение между станциями назад
    self.loc -= 1
  end

  def location # Возвращает предыдущую станцию, текущую, следующую, на основе маршрута
    if (self.loc == 0)
      puts @route.stations[self.loc], @route.stations[self.loc+1] #Если выбрана стартовая станция, то предыдущей нет
    elsif (self.loc == @route.stations.length - 1)
      puts @route.stations[self.loc-1], @route.stations[self.loc] #Если выбрана финишная станция, то следующей нет
    else
      puts @route.stations[self.loc-1], @route.stations[self.loc], @route.stations[self.loc+1] #Вывод предыдущей, текущей и следующей
    end
  end
end
