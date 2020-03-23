require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

a = 0
number_tr = 0
stations = []
ind_station = 0
trains = []
ind_train = 0
routes = []
ind_route = 0
wagons_passenger = []
id_ps = 0
wagons_cargo = []
id_cr = 0

while a != 13
  puts "Нажмите на цифру, чтобы выбрать действие: 1 - создать станцию"
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
  puts "13 - выйти из программы"
  a = gets.chomp.to_i
  case a

  when 1
    puts "Введите название станции:"
    name_st  = gets.chomp
    stations[ind_station] = Station.new(name_st)
    ind_station += 1

  when 2
    puts "Какой поезд вы хотите создать?"
    puts "1 - пассажирский поезд; 2 - грузовой поезд"
    type = gets.chomp.to_i
    puts "Введите номер поезда:"
    number_tr  = gets.chomp
    if type == 1
      trains[ind_train] = PassengerTrain.new(number_tr)
    else
      trains[ind_train] = CargoTrain.new(number_tr)
    end
    ind_train += 1

  when 3
    puts "Введите начальную станцию маршрута"
    puts "Для выбора станции нажмите цифру от 1 до N, где 1 - первая станция из списка"
    puts "Список станций:"
    stations.each { |st| puts st.name }
    index_st1 = gets.chomp.to_i
    puts "------------------------------------------"
    puts "Выберете конечную станцию маршрута"
    puts "Для выбора станции нажмите цифру от 1 до N, где 1 - первая станция из списка"
    puts "Список станций:"
    stations.each { |st| puts st.name }
    index_st2 = gets.chomp.to_i
    routes[ind_route] = Route.new(stations[index_st1 - 1], stations[index_st2 - 1])
    ind_route += 1

  when 4
    puts "Выберите маршрут в который хотите добавить станцию: "
    puts "Для выбора маршрута нажмите цифру от 1 до N, где 1 - первый маршрут из списка"
    puts "Список маршрутов"
    puts routes
    ind_rt = gets.chomp.to_i
    puts "Выберете станцию "
    puts "Для выбора станции нажмите цифру от 1 до N, где 1 - первая станция из списка"
    puts "Список станций:"
    stations.each { |st| puts st.name }
    index_st = gets.chomp.to_i
    routes[ind_rt - 1].add_station(stations[index_st - 1])

  when 5
    puts "Выберите маршрут из которого хотите удалить станцию: "
    puts "Для выбора маршрута нажмите цифру от 1 до N, где 1 - первый маршрут из списка"
    puts routes
    ind_rt = gets.chomp.to_i
    puts "Выберете станцию "
    puts "Список станций в маршруте:"
    routes[ind_rt - 1].print
    puts "Для выбора станции нажмите цифру от 1 до N, где 1 - первая станция из списка"
    index_st = gets.chomp.to_i
    routes[ind_rt - 1].delete_station(stations[index_st - 1])

  when 6
    puts "Выберите поезд, которому хотите добавить маршрут"
    puts "Для выбора поезда нажмите цифру от 1 до N, где 1 - первый поезд из списка"
    puts "Список поездов:"
    trains.each { |tr| puts "номер: #{tr.number} тип: #{tr.type}" }
    ind_tr = gets.chomp.to_i
    puts "Выберите маршрут, который хотите задать поезду: "
    puts "Для выбора маршрута нажмите цифру от 1 до N, где 1 - первый маршрут из списка"
    puts routes
    ind_rt = gets.chomp.to_i
    trains[ind_tr - 1].new_route(routes[ind_rt - 1])

  when 7
    puts "Выберите поезд к которому хотите добавить вагон"
    puts "Для выбора поезда нажмите цифру от 1 до N, где 1 - первый поезд из списка"
    puts "Список поездов:"
    trains.each { |tr| puts "номер: #{tr.number} тип: #{tr.type}" }
    ind_tr = gets.chomp.to_i
    if trains[ind_tr - 1].type == 'passenger'
      wagons_passenger[id_ps] = PassengerWagon.new
      trains[ind_tr - 1].add(wagons_passenger[id_ps])
      id_ps += 1
    elsif trains[ind_tr - 1].type == 'cargo'
      wagons_cargo[id_cr] = CargoWagon.new
      trains[ind_tr - 1].add(wagons_cargo[id_cr])
      id_cr += 1
    end
    puts trains[ind_tr - 1].wagons

  when 8
    puts "Выберите поезд из которого хотите удалить вагон"
    puts "Для выбора поезда нажмите цифру от 1 до N, где 1 - первый поезд из списка"
    puts "Список поездов:"
    trains.each { |tr| puts "номер: #{tr.number} тип: #{tr.type}" }
    ind_tr = gets.chomp.to_i
    if trains[ind_tr - 1].type == 'passenger' && trains[ind_tr - 1].wagons.length != 0
      trains[ind_tr - 1].delete(wagons_passenger[id_ps - 1])
      id_ps -= 1
    elsif trains[ind_tr - 1].type == 'cargo' && trains[ind_tr - 1].wagons.length != 0
      trains[ind_tr - 1].delete(wagons_cargo[id_cr - 1])
      id cr -=1
    end
    puts trains[ind_tr - 1].wagons

  when 9
    puts "Выберите поезд, который проследует на станцию вперед"
    puts "Для выбора поезда нажмите цифру от 1 до N, где 1 - первый поезд из списка"
    puts "Список поездов:"
    trains.each { |tr| puts "номер: #{tr.number}" }
    ind_tr = gets.chomp.to_i
    trains[ind_tr - 1].forward

  when 10
    puts "Выберите поезд, который проследует на станцию вперед"
    puts "Для выбора поезда нажмите цифру от 1 до N, где 1 - первый поезд из списка"
    puts "Список поездов:"
    trains.each { |tr| puts "номер: #{tr.number}" }
    ind_tr = gets.chomp.to_i
    trains[ind_tr - 1].back

  when 11
    puts "Выберите маршрут: "
    puts "Для выбора маршрута нажмите цифру от 1 до N, где 1 - первый маршрут из списка"
    puts "Список маршрутов"
    puts routes
    ind_rt = gets.chomp.to_i
    routes[ind_rt - 1].print

  when 12
    puts "Выберете станцию "
    puts "Для выбора станции нажмите цифру от 1 до N, где 1 - первая станция из списка"
    puts "Список станций:"
    stations.each { |st| puts st.name }
    index_st = gets.chomp.to_i
    puts stations[index_st - 1].trains

  end
end
