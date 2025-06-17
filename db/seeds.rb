puts "✨ Seeding data"

users = []

%w[
  Liam
  Olivia
  Noah
  Emma
  Lucas
  Gavin
  Maya
  Sora
].each do |name|
  user = User.new(name: name)

  users << user if user.save
end

users.each do |user|
  14.times do |i|
    start_time = (i.days.ago + 22.hours + rand(0..120).minutes)
    end_time = start_time + (rand(6..9).hours + rand(0..59).minutes)

    SleepSession.create(
      user: user,
      start_time: start_time,
      end_time: end_time,
      duration: (end_time - start_time).to_i,
      created_at: start_time,
      updated_at: start_time
    )
  end
end

users.each do |user|
  users_to_follow = users.reject { |u| u == user }.sample(3)

  users_to_follow.each do |user_to_follow|
    UserFollow.create(
      follower: user,
      followed: user_to_follow
    )
  end
end

puts "✅ Done"
