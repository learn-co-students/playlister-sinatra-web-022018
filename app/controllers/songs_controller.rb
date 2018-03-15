require "rack-flash"

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/song/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/song/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/song/show'
  end

  post '/songs' do
    @artist = Artist.find_or_create_by(name: params[:song][:artist])
    @song = Song.create(name: params[:song][:name], artist: @artist)

    params[:song][:genre_ids].each do |id|
      SongGenre.create(song_id: @song.id, genre_id: id)
    end
    #binding.pry
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

  get '/songs/:slug/edit' do
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :"/song/edit"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.name = params[:song][:name]
    @artist = Artist.find_or_create_by(name: params[:song][:artist])
    @song.artist = @artist
    selected_genres = SongGenre.all.select{
      |genre|
      genre.song_id == @song.id
    }

    selected_genres.each{
      |genre|
      genre.destroy
    }

    params[:song][:genre_ids].each do |id|
      SongGenre.create(song_id: @song.id, genre_id: id)
    end

    @song.save
    flash[:message] = "Successfully updated song."
    erb :'/song/show'
  end
end
