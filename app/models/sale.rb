class Sale < ApplicationRecord
  # Each sale must belong to one specific product
  belongs_to :product
  validate :enough_inventory

  def enough_inventory
    if quantity > product.inventory_count
      errors.add(:quantity, "exceeds available stock (#{product.inventory_count} left)")
    end
  end
end
