class Sale < ApplicationRecord
   # Each sale must belong to one specific product
   has_many :sale_items, dependent: :destroy
end
