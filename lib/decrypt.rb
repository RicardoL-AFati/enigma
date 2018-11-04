require './lib/enigma'

enigma = Enigma.new

message = File.open(ARGV[0], "r").read

decrypted = enigma.decrypt(message, ARGV[2], ARGV[3])

File.open(ARGV[1], "w").write(decrypted[:decryption])

puts "Created #{ARGV[1]} with the key #{decrypted[:key]} and date #{decrypted[:date]}"
