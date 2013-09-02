Fabricator(:user) do
  email { Faker::Internet.safe_email }
  password 'password1'
  full_name { Faker::Name.name }
  admin false
  active true
end

Fabricator(:admin, from: :user) do
  admin true
end