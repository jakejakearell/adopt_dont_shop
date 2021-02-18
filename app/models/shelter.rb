class Shelter < ApplicationRecord
  has_many :pets

  def self.reverse_order_by_name
    Shelter.find_by_sql("SELECT shelters.* FROM shelters ORDER BY shelters.name DESC")
  end
end
