require "sqlite3"

reason = ARGV.join(' ')

start = Time.now

puts "Starting timer for #{reason.inspect} at #{start}..."
puts "Press Ctrl+C to stop the timer"

channel = Channel(Nil).new

Signal::INT.trap { channel.send(nil) }

# wait for traffic on the channel
channel.receive

finish = Time.now

duration = finish - start

puts "\nStopping timer.  #{duration} seconds elapsed..."

database_url = "sqlite3://#{ENV["HOME"]}/.time-tracker.db"

puts "writing record to #{database_url}"

DB.open(database_url) do |db|
  db.exec "create table if not exists entries (reason VARCHAR(255), start DATETIME, finish DATETIME, duration REAL)"

  args = [] of DB::Any
  args << reason
  args << start
  args << finish
  args << duration.to_f

  db.exec "insert into entries values (?, ?, ?, ?)", args
end

puts "done..."
