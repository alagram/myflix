Fabricator(:video) do
  title { Faker::Lorem.words(5) }
  description { Faker::Lorem.paragraph(2) }
  token '12345abcd'
end