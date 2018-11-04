require './lib/enigma'

enigma = Enigma.new

message = File.open(ARGV[0], "r").read

encrypted = enigma.encrypt(message)

File.open(ARGV[1], "w").write(encrypted[:encryption])

puts "Created #{ARGV[1]} with the key #{encrypted[:key]} and date #{encrypted[:date]}"
