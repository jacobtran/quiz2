1000.times do
  random = rand(3)
  if random == 0
    department = "Sales"
  elsif random == 1
    department = "Marketing"
  else
    department = "Technical"
  end

  SupportRequest.create  name:        Faker::Name.name,
                         email:       Faker::Internet.email,
                         department:  department,
                         message:     Faker::Lorem.paragraph,
                         done:        false
end
