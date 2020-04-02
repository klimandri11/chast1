require_relative 'module_instance_counter'

class Route
  attr_reader :stations
  include InstanceCounter

  def initialize(start, finish)
    @stations = [start, finish]
    self.class.all << self
    register_instance
  end

  def print # выводит список всех станций по-порядку от начальной до конечной
    stations.each { |st| puts st.name }
  end

  def add_station(station)
    stations.insert(-2,station)
  end

  def delete_station(station)
    if station != first_station && station != last_station
      stations.delete(station)
    end
  end

  def first_station
    @stations[0]
  end

  def last_station
    @stations[-1]
  end
end
