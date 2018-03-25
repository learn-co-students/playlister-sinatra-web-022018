class ArtistsController < ApplicationController

  get '/artists/new' do
    erb :'artists/new'
  end

  post '/artists' do
    @artist = Artist.create(params)
    redirect "/artists/#{@artist.slug}"
  end

  get '/artists' do
    @artists = Artist.all
    erb :'artists/index'
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'artists/show'
  end

  get '/artists/:slug/edit' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'artist/edit'
  end

  post '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    redirect "/artists/#{@artist.slug}"
  end

end
