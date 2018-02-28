brisbane = {
  latitude: "-27.470125",
  longitude: "153.021072",
  postcode: 9999,
  nicknames: ['Brisy', 'Brisvegas']
}

# Brisbane's postcode is incorrect. Update it
brisbane[:postcode] = 4000

# Show brisbane's postcode on screen
puts brisbane[:postcode]

# Show Brisbane's latitude and longitude on screen
# separated by a comma
puts "Brisbane's latitude is: #{brisbane[:latitude]}, Brisbane's longitude is: #{brisbane[:longitude]}"

# Brisbane's population is 2500000 - add it to the hash.
brisbane[:population] = 2500000

# Add 'Brisbo' to Brisbane's nicknames
brisbane[:nicknames].push("Brisbo")

# Loop through Brisbane's nicknames and put each on screen.
brisbane[:nicknames].each do |nickname|
  puts nickname
end
