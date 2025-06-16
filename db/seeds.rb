puts "Seeding data.."

%w[
  Liam
  Olivia
  Noah
  Emma
  Lucas
].each do |name|
  User.create({ name: name })
end


puts "✅ Done."
