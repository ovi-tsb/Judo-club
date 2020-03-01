

# 20.times do |post|
#   Post.create!(date: Date.today, details: "#{post} details content")
# end

# puts "20 Posts have been created"

@user1 = AdminUser.create!(email: "admin@yahoo.com", 
                password: "123456", 
                password_confirmation: "123456", 
                first_name: "Admin", 
                last_name: "Admin"
                )

puts "1 Admin User created"

