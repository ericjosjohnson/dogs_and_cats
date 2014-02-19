# model a world where people own one or more pets
# pets like to eat food
# pets say things appropriate to their kind

def assert(truthy)
  raise "something broke!" unless truthy
  true
end

def assert_equal(actual, expected)
  raise "expected #{expected} but got #{actual}" unless actual == expected
  true
end

################################################################################
# design the world here

class Pet
  attr_accessor :hungry, :antsy
  def initialize
    @hungry = true
    @antsy = true
  end
  def hungry?
    @hungry
  end
  def eat!
    @hungry = false
    true
  end
  def walk!
    @antsy = false
    true
  end
  def antsy?
    @antsy
  end
end

class Dog < Pet
end

class Cat < Pet
end

class Person
  def initialize
    @pets = []
  end

  def pets
    @pets
  end

  def add_pets(pet)
    @pets << pet
  end

  def feed(pet)
    pet.hungry = false
    true
  end

  def walk(pet)
    pet.antsy = false
    true
  end
end
################################################################################
# prepare for our assertions here

fido = Dog.new
precious = Cat.new
bob = Person.new
bob.add_pets(fido)
bob.add_pets(precious)
# bob.feed(fido)

################################################################################

# there exists a dog, a cat and a person
assert_equal fido.class, Dog
assert_equal precious.class, Cat
assert_equal bob.class, Person

# # bob owns them
assert bob.pets.include? fido
assert bob.pets.include? precious

# # bob walks them and feeds them
assert_equal fido.hungry?, true
rand(2) > 0 ? assert(fido.eat!) : assert(bob.feed fido)
assert_equal fido.hungry?, false

assert_equal fido.antsy?, true
# rand(2) > 0 ? assert(fido.walk!) : (assert bob.walk fido)
rand(2) > 0 ? assert(fido.walk!) : assert(bob.walk fido)

assert_equal fido.antsy?, false
# ------------------------------------------------
# A couple more asserts from Eric
assert(bob.respond_to?("walk"))
assert(fido.instance_variable_defined?("@antsy"))
