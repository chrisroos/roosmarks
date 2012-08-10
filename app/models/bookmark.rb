require 'uri'

class Bookmark < ActiveRecord::Base
  validates :url, :title, presence: true
  validates :url, uniqueness: true
  has_and_belongs_to_many :tags
  attr_accessible :url, :title, :comments, :tag_names

  before_save :save_tags

  def domain
    URI.parse(url).host
  end

  private

  def save_tags
    self.tags = (tag_names || '').split(' ').collect { |tag_name| Tag.find_or_create_by_name(tag_name) }.uniq
  end
end
