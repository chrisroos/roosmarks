class Tag < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :bookmarks
  attr_accessible :name, :description
end