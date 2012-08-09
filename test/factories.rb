FactoryGirl.define do
  sequence :url do |n|
    "http://example.com/#{n}"
  end

  factory :bookmark do
    url
    title 'example.com'
  end

  factory :tag do
    name 'tag-name'
  end
end