require 'uri'

class Bookmark < ActiveRecord::Base
  validates :url, :title, presence: true
  validates :url, uniqueness: true
  has_and_belongs_to_many :tags
  attr_accessor :tag_names
  attr_accessible :url, :title, :comments, :tags

  def domain
    URI.parse(url).host
  end
end
