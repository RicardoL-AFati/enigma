require './lib/enigma'

enigma = Enigma.new

input_file = File.open(ARGV[0], "r")
message = input_file.read
input_file.close

decrypted = enigma.decrypt(message, ARGV[2], ARGV[3])

output_file = File.open(ARGV[1], "w")
output_file.write(encrypted[:encryption])
output_file.close

puts "Created #{ARGV[1]} with the key #{encrypted[:key]} and date #{encrypted[:date]}"

require "pry"; binding.pry
