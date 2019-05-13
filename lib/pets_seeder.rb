require "faker"
require_relative "./pets_seeder/version"

module PetsSeeder
  Pet = Struct.new(:name, :age, :type, :owner_id)
  Owner = Struct.new(:id, :name)

  class Error < StandardError; end

  class Start
    def initialize
      @pets = []
      @owners = Array.new(12).map.with_index { |_, id|
        rand(1..5).times { @pets << create_pet(id) }
        Owner.new(id, "#{Faker::Name.first_name} #{Faker::Name.last_name}")
      }

      @file = File.new("seed.sql", "w+")
      @file.puts create_table_statements
      @owners.each { |owner| @file.puts insert_sql_owner(owner) }
      @pets.each { |pet| @file.puts insert_sql_pet(pet) }
      @file.close
      system("rm db && touch db && sqlite3 db < seed.sql")
    end

    def create_pet(owner_id)
      name = Faker::Name.first_name
      age = rand(1...4)
      type = ["dog", "cat", "lama", "fish", "hamster", "geko"].sample
      Pet.new(name, age, type, owner_id)
    end

    def create_table_statements
      <<~SQL
        CREATE TABLE owners(id INTEGER PRIMARY KEY, name TEXT);
        CREATE TABLE pets(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, type TEXT, owner_id INTEGER);
      SQL
    end

    def insert_sql_owner(owner)
      "INSERT INTO owners(id, name) VALUES (#{owner.id},'#{owner.name}');"
    end

    def insert_sql_pet(pet)
      <<-SQL
        INSERT INTO pets(name, age, type, owner_id)
        VALUES ('#{pet.name}', '#{pet.age}', '#{pet.type}', '#{pet.owner_id}');
      SQL
    end
  end
end
