class Bookmark < ActiveRecord::Base
  validates :url, :title, presence: true
end
