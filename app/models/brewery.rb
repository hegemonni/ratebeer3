class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: { less_than_or_equal_to: Proc.new { Time.now.year } }

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil, false]}

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(n)
     sorted_by_rating_in_desc_order = Brewery.all.limit(n).sort_by{ |b| -(b.average_rating||0) } 
  end
end