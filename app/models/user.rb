class User < ActiveRecord::Base
	include Createable

  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true
  validates :username, length: {in: 1..40}

  def top_three_tags
  	occurances = occurance_hash(all_tags)
  	ordered_hash = occurances.sort_by{|_key, value| value}.to_h
    ordered_hash.keys.pop(3)
  end

  private

  def all_tags
  	self.questions.map do |question|
  		question.tags
  	end.flatten
  end

  def occurance_hash(tags_array)
  	hash = Hash.new(0)
  	tags_array.each do |tag|
  		hash[tag] += 1
  	end
  	hash
  end
  
end
