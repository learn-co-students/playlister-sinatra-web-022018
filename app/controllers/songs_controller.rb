class SongsController < ApplicationController

  enable :sessions
  use Rack::Flash

  get '/songs' do
    erb :"/songs/index"
  end

  get '/songs/new' do
    erb :"/songs/new"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/edit"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/show"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    if !params[:genre][:genre_ids].empty?
      @song.genres = params[:genre][:genre_ids].collect {|genre| Genre.find(genre)}
    end
    if !params[:genre][:name].empty?
      genre = Genre.find_or_create_by(name: params[:genre][:name])
      @song.genres << genre
    end
    @song.save
    redirect "/songs/#{@song.slug}"
  end

  delete '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.destroy
    redirect '/songs'
  end

  post '/songs' do
    @song = Song.find_or_create_by(params[:song])
    @song.genres = params[:genre][:genre_ids].collect {|genre| Genre.find(genre)}
    if !params[:artist][:name].empty?
      artist = Artist.create(name: params[:artist][:name])
      @song.artist = artist
    end
    if !params[:genre][:name].empty?
      genre = Genre.find_or_create_by(name: params[:genre][:name])
      @song.genres << genre
    end
    @song.save
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

end
