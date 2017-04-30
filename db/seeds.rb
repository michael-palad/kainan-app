# Kainan-App seed file

# 1. Delete old records
puts "Deleting old records..."

User.destroy_all
Restaurant.destroy_all
Star.destroy_all

# 2. Create sample users
generic_password = 'kaintayo'
emails = ['terry@email.com', 'erick@email.com', 'sandara@email.com',
          'jimmy@email.com', 'ayane@gmail.com']

users = []
puts "Creating users..."
emails.each do |email|
  puts "#{email}"
  user =  User.create(email: email,  password: generic_password)
  users << user
end

# 3. Create restaurant data
Restaurant_Count = 50

def get_random_name
  first_part_type = rand(1..5)
  case first_part_type
  when 1
    first_part = Faker::Name.name
  when 2
    first_part = Faker::Superhero.name
  when 3
    first_part = Faker::Pokemon.name
  when 4
    first_part = Faker::StarWars.character
  when 5
    first_part = Faker::Zelda.game
  end
      
  extension = ['Eatery', 'Diner', 'Kainan', 'Bar', 'Restaurant']
  "#{first_part}'s #{extension[rand(0..(extension.length - 1))]}"
end

def get_random_address
  address = Faker::Address.street_address + ", " +
            Faker::Address.city + ", " +
            Faker::Address.state
  address
end

def get_random_telephone_number
  rand_phone = "02 #{rand(0..9)}#{rand(0..9)}#{rand(0..9)}-" +
               "#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
  rand_phone
end

def get_random_cuisine
  cuisines = %w(Filipino Chinese American Korean Fastfood)
  cuisines[rand(0..4)]
end

user_index = 0
restaurants = []
puts "Creating restaurants..."
1.upto(Restaurant_Count) do |num|
  name = get_random_name
  puts "for #{name}"
  resto = Restaurant.new
  resto.name = name
  resto.address = get_random_address
  resto.telephone_number = get_random_telephone_number
  resto.cuisine = get_random_cuisine
  resto.user = users[user_index]
  puts "--Name: #{resto.name}"
  puts "--Address: #{resto.address}"
  puts "--Tel: #{resto.telephone_number}"
  puts "--Cuisine: #{resto.cuisine}"
  if resto.save
    puts "--#{resto.name} saved"  
  else
    puts "--Error saving #{resto.name}"
  end
  restaurants << resto
  
  user_index = (user_index >= users.size - 1) ? 0 : user_index + 1
end

# 4. Add Starring Users 
puts "Adding starring users..."
restaurants.each do |resto|
  puts "for #{resto.name}"
  starring_users_count = Random.rand(0..(users.size))
  i = 0
  while i < starring_users_count
    if resto.user != users[i]
      resto.starring_users << users[i]
    end
    i += 1
  end
end


puts "Seeding Done."