# Add seed data here. Seed your database with `rake db:seed`
a = Artist.create(name: "York")
b = Artist.create(name: "Sinclair")
Song.create(name: "hi", artist: a)
Song.create(name: "hello", artist: b)
Genre.create(name: "pop")
