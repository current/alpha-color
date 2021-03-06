class Vote < ActiveRecord::Base
  validates_presence_of :color, :word

  def self.random(attributes = {})
    new do |vote|
      vote.word  = attributes[:word]  || random_word
      vote.color = attributes[:color] || random_color
    end
  end

  def self.random_color
    format("%06x", rand(0xFFFFFF+1))
  end

  def self.random_word
    Words.sample
  end

  def self.register(vote_params)
    @vote = Vote.where(vote_params).first || Vote.new(vote_params)
    @vote.total += 1
    @vote
  end
end
