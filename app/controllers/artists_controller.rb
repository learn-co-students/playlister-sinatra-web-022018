class ArtistsController < ApplicationController

  enable :sessions
  use Rack::Flash

  get '/artists' do
    erb :"/artists/index"
  end

  get '/artists/new' do
    erb :"/artists/new"
  end

  get '/artists/:slug/edit' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :"/artists/edit"
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :"/artists/show"
  end

  patch '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    @artist.update(params[:artist])
    @artist.slugify
    @artist.save
    redirect "/artists/#{@artist.slug}"
  end

  delete '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    @artist.destroy
    redirect '/artists'
  end

  post '/artists' do
    @artist = Artist.find_or_create_by(params[:artist])
    @artist.save
    if !params[:song][:name].empty?
      song = Song.create(name: params[:song][:name])
      genre = Genre.find_or_create_by(name: params[:song][:genre])
      song.genres << genre
      song.artist = @artist
    end
    song.save
    flash[:message] = "Successfully created artist."
    redirect "/artists/#{@artist.slug}"
  end

end
