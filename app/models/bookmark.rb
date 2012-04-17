require 'uri'

class Bookmark < ActiveRecord::Base
  validates :url, :title, presence: true
  has_and_belongs_to_many :tags
  attr_accessor :tag_names

  def domain
    URI.parse(url).host
  end
end
