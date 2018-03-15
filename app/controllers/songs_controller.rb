class SongsController < ApplicationController
  get "/songs" do
    @songs = Song.all
    erb :"songs/index"
  end

  get "/songs/new" do
    erb :"songs/new"
  end

  post "/songs" do
    art = Artist.find_or_create_by(name: params[:song][:artist])
    @song = Song.create(name: params[:song][:name], artist_id: art.id, genre_ids: params[:song][:genre_ids])
    redirect "/songs/#{@song.slug}"
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    erb :"songs/show"
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  patch "/songs/:slug" do
    # binding.pry
    @song = Song.find_by_slug(params[:slug])
    art = Artist.find_or_create_by(name: params[:song][:artist])
  
    @song.update(name: params[:song][:name], artist_id: art.id, genre_ids: params[:song][:genre_ids])


    @song.save
    redirect "/songs/#{@song.slug}"
  end
end
