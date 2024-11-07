require './gemstone' # put your record definition in gemstone.rb

def main()
    # put your code here
    gem = Gemstone.new
    gem.name = "Diamond"
    gem.polarising = Polarising::Isotropic
    gem.hardness = 10

    puts gem.name
    puts Polarising_names[gem.polarising]
    puts gem.hardness
end

main()