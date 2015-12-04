class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions

  validates :name, presence:true
  validates :name, length: {in: 1..30}

  # def self.today
  #   where("created_at >= ?", Time.zone.now.beginning_of_day)
  # end

  # def self.this_week
  #   where("created_at >= ?", Time.zone.now.beginning_of_day - 7.days)
  # end
end