class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions

  validates :name, presence:true
  validates :name, length: {in: 1..30}
end
