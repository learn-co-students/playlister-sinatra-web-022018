out = ""
i = 0
Dir.foreach('db/data') do |item|
  if i > 1
    artist = item.split(" - ")[0]
    song = item.split(" - ")[1].split(" [")[0]
    genre = item.split(" - ")[1].split(" [")[1].split("]")[0]
    add_artist = "Artist.find_or_create_by(name: `#{artist}`)\n"
    add_song = "Song.create(name: `#{song}`, artist: Artist.find_or_create_by(name: `#{artist}`))\n"
    add_genre = "Genre.find_or_create_by(name: `#{genre}`)\n"
    add_rel = "SongGenre.create(song_id: Song.find_by(name: `#{song}`).id, genre_id: Genre.find_by(name: `#{genre}`).id)\n"
    out = out + add_artist + add_song + add_genre + add_rel
  end
  i += 1
  File.write("db/seeds.rb", out)
end
