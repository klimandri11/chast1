module Manufacturer
  def indicate_name(name)
    self.name_manufacturer = name
  end

  def get_name_manufacturer
    self.name_manufacturer
  end

  protected
  attr_accessor :name_manufacturer
end
