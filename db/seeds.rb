# Add seed data here. Seed your database with `rake db:seed`
aa = Artist.create(name: "Bob")
ab = Song.create(name: "Bob's song", artist: aa)
ac = Genre.create(name: "rock")

ad = SongGenre.create(song_id: ab.id, genre_id: ac.id)
