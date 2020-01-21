20.times do |post|
  Post.create!(date: Date.today, details: "#{post} details content")
end

puts "20 Posts have been created"