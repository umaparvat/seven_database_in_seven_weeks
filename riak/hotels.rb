# This is the working code on riak 2.9.10. This code is reference from seven database in seven weeks book
require 'rubygems'
require 'riak'
STYLES = %w{singel double queen king suite}

client = Riak::Client.new(:nodes => [ {:host => '192.168.44.128', :pb_port => 8087} ])
bucket = client.bucket('rooms')
#create 100 floors to the building
for floor in 1..100
  current_rooms_block = floor * 100
  puts "Making rooms #{current_rooms_block} - #{current_rooms_block + 100}"
  for room in 1...100
    ro = Riak::RObject.new(bucket, (current_rooms_block + room).to_s(10))
    style = STYLES[rand(STYLES.length)]
    capacity = rand(8) + 1
    ro.content_type = "application/json"
    ro.data = {'style' => style, 'capacity' => capacity}
    ro.store

  end

end
