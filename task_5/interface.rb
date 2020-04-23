class Interface

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @ind_station = 0
    @ind_train = 0
    @ind_route = 0
    @wagons_passenger = []
    @id_ps = 0
    @wagons_cargo = []
    @id_cr = 0
  end

  def run
    menu
  end

  private

  def menu_information
    puts "Нажмите на цифру, чтобы выбрать действие:"
    puts "1 - создать станцию"
    puts "2 - создать поезд"
    puts "3 - создать маршрут"
    puts "4 - добавить станцию в маршрут"
    puts "5 - удалить станцию из маршрута"
    puts "6 - назначить маршрут поезду"
    puts "7 - добавить вагон к поезду"
    puts "8 - отцепить вагон от поезда"
    puts "9 - переместить поезд на станцию вперед"
    puts "10 - переместить поезд на станцию назад"
    puts "11 - просмотреть список станций в маршруте"
    puts "12 - просмотреть список поездов на станции"
    puts "13 - создать вагон"
    puts "14 - занять место в пассажирсом вагоне"
    puts "15 - занять объем в грузовом вагоне"
    puts "16 - выйти из программы"
  end

  def list_stations
    line_number = 0
    puts "Для выбора станции нажмите цифру от 1 до #{@stations.size}"
    puts "Список станций:"
    @stations.each do |st|
      puts "#{line_number += 1}: #{st.name}"
    end
  end

  def list_passenger_wagons
    line_number = 0
    puts "Для выбора вагона нажмите цифру от 1 до #{@wagons_passenger.size}"
    puts "Список вагонов:"
    @wagons_passenger.each do |wagon|
      puts "#{line_number += 1} тип: #{wagon.class.name} количество свободных мест: #{wagon.free} количество занятых мест: #{wagon.occupied}"
    end
  end

  def list_cargo_wagons
    line_number = 0
    puts "Для выбора вагона нажмите цифру от 1 до #{@wagons_cargo.size}"
    puts "Список вагонов:"
    @wagons_cargo.each do |wagon|
      puts "#{line_number += 1} тип: #{wagon.class.name} количество свободного объема: #{wagon.free} количество занятого объема: #{wagon.occupied}"
    end
  end

  def list_trains
    line_number = 0
    puts "Для выбора поезда нажмите цифру от 1 до #{@trains.size}"
    puts "Список поездов:"
    @trains.each { |train| puts "#{line_number += 1}: номер поезда #{train.number}" }
  end

  def list_routes
    line_number = 0
      puts "Для выбора маршрута нажмите цифру от 1 до N, где 1 - первый маршрут из списка"
      puts "Список маршрутов:"
      puts @routes
  end

  def create_wagon
    puts "Вагон какого типа хотите создать?"
    puts "1 - Пассажирский 2 - Грузовой"
    type = gets.chomp.to_i
    if type == 1
      puts "Введите количество мест в вагоне"
      number_seats = gets.chomp.to_i
      @wagons_passenger[@id_ps] = PassengerWagon.new(number_seats)
      @id_ps += 1
    else
      puts "Введите общий объем вагона"
      total_volume = gets.chomp.to_i
      @wagons_cargo[@id_cr] = CargoWagon.new(total_volume)
      @id_cr += 1
    end
  end

  def create_stations
    puts "Введите название станции:"
    name_st  = gets.capitalize.chomp
    @stations[@ind_station] = Station.new(name_st)
    @ind_station += 1
  end

  def create_train
    puts "Какой поезд вы хотите создать?"
    puts "1 - пассажирский поезд; 2 - грузовой поезд"
    type = gets.chomp.to_i
    puts "Введите номер поезда:"
    number_tr  = gets.chomp
    if type == 1
      @trains[@ind_train] = PassengerTrain.new(number_tr)
    else
      @trains[@ind_train] = CargoTrain.new(number_tr)
    end
    @ind_train += 1
  end

  def create_route
    if @stations.length >= 2
      puts "Введите начальную станцию маршрута"
      list_stations
      index_st1 = gets.chomp.to_i
      puts "------------------------------------------"
      puts "Выберете конечную станцию маршрута"
      list_stations
      index_st2 = gets.chomp.to_i
      @routes[@ind_route] = Route.new(@stations[index_st1 - 1], @stations[index_st2 - 1])
      @ind_route += 1
    else
      puts "Недостаточно станций для создания маршрута"
    end
  end

  def add_station
    if @routes.length != 0
      puts "Выберите маршрут в который хотите добавить станцию: "
      list_routes
      index_rt = gets.chomp.to_i
      puts "Выберете станцию "
      list_stations
      index_st = gets.chomp.to_i
      @routes[index_rt - 1].add_station(@stations[index_st - 1])
    else
      puts "Маршруты еще не созданы"
    end
  end


  def delete_station
    if @routes.length != 0
      puts "Выберите маршрут из которого хотите удалить станцию: "
      puts "Выберите маршрут: "
      list_routes
      index_rt = gets.chomp.to_i
      @routes[index_rt - 1].print
      puts "Выберете станцию "
      puts "Для выбора станции нажмите цифру от 1 до N, где 1 - первая станция из списка"
      index_st = gets.chomp.to_i
      @routes[index_rt - 1].delete_station(@stations[index_st - 1])
    else
      puts "Маршруты еще не созданы"
    end
  end

  def assign_route
    if @trains.length != 0
      puts "Выберите поезд, которому хотите добавить маршрут"
      list_trains
      index_tr = gets.chomp.to_i
      puts "Выебрите маршрут, который хотите задать поезду"
      list_routes
      index_rt = gets.chomp.to_i
      @trains[index_tr - 1].new_route(@routes[index_rt - 1])
    else
      puts "Поезда еще не созданы"
    end
  end

  def add_wagon
    if @trains.length != 0
      puts "Выберите поезд к которому хотите добавить вагон"
      list_trains
      index_tr = gets.chomp.to_i
      if @trains[index_tr - 1].is_a?(PassengerTrain) && @wagons_passenger.length != 0
        puts "Выебрите вагон:"
        list_passenger_wagons
        index_wg = gets.chomp.to_i
        @trains[index_tr - 1].add(@wagons_passenger[index_wg - 1])
      elsif @trains[index_tr - 1].is_a?(CargoTrain) && @wagons_cargo.length != 0
        puts "Выебрите вагон:"
        list_cargo_wagons
        index_wg = gets.chomp.to_i
        @trains[index_tr - 1].add(@wagons_cargo[index_wg - 1])
      else
        puts "Вагоны не созданы"
      end
    else
      puts "Поезда еще не созданы"
    end
  end

  def delete_wagon
    line_number = 0
    if @trains.length != 0
      puts "Выберите поезд из которого хотите удалить вагон"
      list_trains
      index_tr = gets.chomp.to_i
      if @trains[index_tr - 1].is_a?(PassengerTrain) && @trains[index_tr - 1].wagons.length != 0
        puts "Выебрите вагон:"
        @trains[index_tr - 1].train_block { |wagon| puts "#{line_number += 1} тип: #{wagon.class.name} количество свободных мест: #{wagon.free} количество занятых мест: #{wagon.occupied}" }
        index_wg = gets.chomp.to_i
        @trains[index_tr - 1].delete(@wagons_passenger[index_wg - 1])
        @id_ps -= 1
      elsif @trains[index_tr - 1].is_a?(CargoTrain) && @trains[index_tr - 1].wagons.length != 0
        puts "Выебрите вагон:"
        @trains[index_tr - 1].train_block { |wagon| puts "#{line_number += 1} тип: #{wagon.class.name} количество свободного объема: #{wagon.free} количество занятого объема: #{wagon.occupied}" }
        index_wg = gets.chomp.to_i
        @trains[index_tr - 1].delete(@wagons_cargo[index_wg - 1])
        @id_cr -=1
      end
    else
      puts "Поезда еще не созданы"
    end
  end

  def train_forward
    if @trains.length != 0
      puts "Выберите поезд, который проследует на станцию вперед"
      list_trains
      index_tr = gets.chomp.to_i
      @trains[index_tr - 1].forward
    else
      puts "Поезда еще не созданы"
    end
  end

  def train_back
    if @trains.length != 0
      puts "Выберите поезд, который проследует на станцию вперед"
      list_trains
      index_tr = gets.chomp.to_i
      @trains[index_tr - 1].back
    else
      puts "Поезда еще не созданы"
    end
  end

  def list_stations_route
    if @routes.length != 0
      puts "Выберите маршрут: "
      list_routes
      index_rt = gets.chomp.to_i
      @routes[index_rt - 1].print
    else
      puts "Маршруты еще не созданы"
    end
  end

  def list_trains_station
    if @stations.length != 0
      puts "Выберете станцию "
      list_stations
      index_st = gets.chomp.to_i
      @stations[index_st - 1].station_block { |trains| puts "Номер:#{trains.number} Тип:#{trains.class.name} Количество вагонов: #{trains.wagons.size} "}
    else
      puts "Станции еще не созданы"
    end
  end

  def add_seat
    puts "Выебрите вагон:"
    list_passenger_wagons
    index_wg = gets.chomp.to_i
    @wagons_passenger[index_wg - 1].add_value(1)
  end

  def fill_volume
    puts "Выебрите вагон:"
    list_cargo_wagons
    index_wg = gets.chomp.to_i
    puts "Какой объем вы хотите занять?"
    volume = gets.chomp.to_i
    @wagons_cargo[index_wg - 1].add_value(volume)
  end


  def menu
    a = 0
    while a != 16
      menu_information
      a = gets.chomp.to_i
      case a

      when 1
        begin
        create_stations
        puts "Станция создана"
      rescue
        puts "Название станции неверное, введите заново"
        puts "------------------------------------------------------------"
        retry
      end

      when 2
        begin
        create_train
        puts "Поезд создан"
      rescue
        puts "Номер поезда указан неверно, введите заново"
        puts "------------------------------------------------------------"
        retry
      end

      when 3
        begin
        create_route
        puts "Маршрут создан"
      rescue
        puts "Ошибка при создании маршрута, попробуйте заново"
        puts "------------------------------------------------------------"
        retry
      end

      when 4
        add_station

      when 5
        delete_station

      when 6
        assign_route

      when 7
        add_wagon

      when 8
        delete_wagon

      when 9
        train_forward

      when 10
        train_back

      when 11
        list_stations_route

      when 12
        list_trains_station

      when 13
        create_wagon
        puts "вагон создан"

      when 14
        add_seat

      when 15
        fill_volume

      end

    end
  end
end
