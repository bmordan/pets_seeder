require_relative "../lib/pets_seeder.rb"

RSpec.describe PetsSeeder do
  before :each do
    system = double()
    allow(system).to receive(:cmd).and_return(true)
  end

  it "has a version number" do
    expect(PetsSeeder::VERSION).not_to be nil
  end

  it "does something useful" do
    pets = PetsSeeder::Start.new
    expect(pets.class).to be(PetsSeeder::Start)
  end

  it "generates a pet" do
    pet = PetsSeeder::Pet.new("test", 3, :dog)
    expect(pet.name).to eq("test")
    expect(pet.age).to be(3)
    expect(pet.type).to be(:dog)
  end

  it "starts with 120 pets" do
    start = PetsSeeder::Start.new
    expect(start.pets.length).to eq(120)
  end

  it "creates an opening sql statement" do
    start = PetsSeeder::Start.new
    expect(start.create_table_statement.class).to eq(String)
  end

  it "writes sql statements into a file" do
    start = PetsSeeder::Start.new
    file = File.read('seed.sql')
    expect(file.class).to be(String)
    expect(file.include?(start.pets.last.name)).to be(true) 
  end
end
