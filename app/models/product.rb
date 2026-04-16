class Product < ApplicationRecord
    validates :name, presence: true
    has_many :sales, dependent: :destroy
end
