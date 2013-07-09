Fabricator(:user) do
  email { Faker::Internet.safe_email }
  password 'password'
  full_name { Faker::Name.name } 
end