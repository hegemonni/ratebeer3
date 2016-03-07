class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :style, presence: true

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    "#{name} #{brewery.name}"
  end

  # def rated_beers

  # end

  def self.top(n)
  	# rated_beers = Rating.each{ |beer| beer.rating != nil }
   #  ratings = Rating.all
  	# rated_beers = []
  	# ratings.each { |rating| rated_beers.push(rating.beer) }
  	# rated_beers = Beer.where{ |b| b.ratings.count > 0 }
    sorted_by_rating_in_desc_order = Beer.all.limit(n).sort_by{ |b| -(b.average_rating||0) }
  end
end
