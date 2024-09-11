class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  validates :name, :price, :description, presence: true

  def self.search(search)
    if search
      where("name LIKE ?", "%#{search}%")
    else
      where()
    end
  end
end
