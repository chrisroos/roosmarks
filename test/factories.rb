FactoryGirl.define do
  factory :bookmark do
    url   'http://example.com'
    title 'example.com'
  end

  factory :tag do
    name 'tag-name'
  end
end