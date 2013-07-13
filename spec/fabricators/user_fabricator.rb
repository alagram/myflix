Fabricator(:user) do
  email { Faker::Internet.safe_email }
  password 'password1'
  full_name { Faker::Name.name } 
end