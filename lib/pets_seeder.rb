require "faker"
require "pry"
require_relative "./pets_seeder/version"

module PetsSeeder
  Pet = Struct.new(:name, :age, :type)
  
  class Error < StandardError; end
  
  class Start
    attr_reader :pets

    def initialize
      @pets = Array.new(120)
        .collect {|*|
          name = Faker::Name.first_name
          age = rand(1...4)
          type = [:dog, :cat, :lama, :fish, :hamster, :geko].sample
          Pet.new(name, age, type)
        }

      @file = File.new("seed.sql", "w+")
      @file.puts create_table_statement
      create_insert_statements
      @file.close
      system("rm db && touch db && sqlite3 db < seed.sql")
    end 

    def insert_values(pet)
      ['"' + pet.name + '"', pet.age, '"' + pet.type.to_s + '"'].join(",")
    end

    def create_table_statement
      <<~SQL
        CREATE TABLE pets(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, type TEXT);
      SQL
    end

    def create_insert_statements
      @pets.each {|pet|
        @file.puts "INSERT INTO pets (name, age, type) VALUES (#{insert_values pet});"
      }
    end
  end
end
