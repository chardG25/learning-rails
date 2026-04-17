class Product < ApplicationRecord
    validates :name, presence: true
    has_many :sale_items
end
