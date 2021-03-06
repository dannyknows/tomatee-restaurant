# Cleanup - Order is important!
Restaurant.destroy_all
User.destroy_all

# Create users
user_admin = User.create(email: 'admin@restaurant.com', password: 'password', admin: true)
user_one = User.create(email: 'test-user1@restaurant.com', password: 'password')
user_two = User.create(email: 'test-user2@restaurant.com', password: 'password')


# Create restaurants
4.times do
    r = Restaurant.create(
      name: Faker::Restaurant.name,
      location: Faker::Address.state,
      cuisine: Faker::Restaurant.type,
      description: Faker::Restaurant.description,
      user: user_one
    )
    num = rand(1..4)
    r.image.attach(io: File.open("app/assets/images/seed/#{num}.jpg"), filename: "#{num}.jpg", content_type: 'image/jpg')
    puts "#{r.name} created!"
    r = Restaurant.create(
      name: Faker::Restaurant.name,
      location: Faker::Address.state,
      cuisine: Faker::Restaurant.type,
      description: Faker::Restaurant.description,
      user: user_two
    )
    num = rand(1..4)
    r.image.attach(io: File.open("app/assets/images/seed/#{num}.jpg"), filename: "#{num}.jpg", content_type: 'image/jpg')
    puts "#{r.name} created!"
end
