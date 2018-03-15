require 'rack-flash'
class SongsController < ApplicationController
	enable :sessions
	use Rack::Flash

	get '/songs' do
		@songs = Song.all
		erb :'/songs/index'
	end

	get '/songs/new' do
		@genres = Genre.all
		erb :'/songs/new'
	end

	get '/songs/:slug' do
		@song = Song.find_by_slug(params[:slug])
		@genres = @song.genres
		erb :'/songs/show'
	end

	get '/songs/:slug/edit' do
		@song = Song.find_by_slug(params[:slug])
		@genres = Genre.all
		erb :'/songs/edit'
	end

	post '/songs' do
		@song = Song.create(name:params["Name"])
		if params["Artist Name"]
			@artist = Artist.find_or_create_by(name:params["Artist Name"])
			@song.artist = @artist

		end
		params[:genres].each do |g|
			@genre = Genre.find_by(name: g)
			SongGenre.create(song_id: @song.id, genre_id: @genre.id)
		end
		@song.save
		flash[:message] = "Successfully created song."
		redirect "/songs/#{@song.slug}"
	end

	patch '/songs/:slug' do
		@song = Song.find_by_slug(params[:slug])
		@artist = Artist.find_or_create_by(name:params["Artist Name"])
		@song.name = params["Name"]
		@song.artist = @artist
		params[:genres].each do |g|
			@genre = Genre.find_by(name: g)
			SongGenre.create(song_id: @song.id, genre_id: @genre.id)
		end
		@song.save
		flash[:message] = "Successfully updated song."
		redirect "/songs/#{params[:slug]}"
	end



end
