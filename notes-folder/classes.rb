class Dog
  attr_reader :name, :age, :location
  def initialize(name, age, location)
    @name = name
    @age = age
    @location = location
  end

  def speak
    puts "Woof! My name is #{name}. My age is #{age} years old."
  end

  def walk
    puts "I love to walk!"
  end

end

# Creates a new object named doggo from the class Dog
doggo = Dog.new("Doggo", "2", "Brisbane")

puts doggo.name # => "Doggo"

puts doggo.location # => "Brisbane"

doggo.speak # => "Woof! My name is Doggo!. My age is 2 years old."

doggo.walk # => "I love to walk!"
