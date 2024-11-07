module Polarising
  Anisotropic, Isotropic, Unknown = *1..2
end

Polarising_names = ["Null", "Anisotropic", "Isotropic", "Unknown"]

# Put your record definition here
# use the keywords class and attr_accessor
# remember each field must have a : before it e.g :field
# Don't have an initialize() method.
class Gemstone 
 attr_accessor :name, :polarising, :hardness
end