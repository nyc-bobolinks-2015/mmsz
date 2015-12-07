class User < ActiveRecord::Base
	include Createable

  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :username, length: {in: 1..40}

  def top_three_tags
  	occurances = occurance_hash(all_tags)
  	ordered_tags_hash = occurances.sort_by{|_key, value| -value}.to_h
    top_tags_objects = ordered_tags_hash.keys.shift(3)
    top_tags_objects.map(&:name)
  end

  def recent_three_questions
    questions.order(created_at: :DESC).limit(3)
  end

  def recent_three_answers
    answers.order(created_at: :DESC).limit(3)
  end

  def karma
    karma_array = self.questions.map(&:vote_count) + self.answers.map(&:vote_count)
    karma_array.reduce(:+)
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
