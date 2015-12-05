class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions

  validates :name, presence:true
  validates :name, length: {in: 1..30}

  def self.latest
    Tag.all.order(updated_at: :desc)
  end

  def self.greatest
    tags = Tag.all
    tags = tags.sort_by{|tag| -tag.questions.count}
  end

end