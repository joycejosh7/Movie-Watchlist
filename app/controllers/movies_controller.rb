class MoviesController < ApplicationController
    get '/movies' do
        @movies = Movie.all 
        erb :'movies/index'
    end

    get '/movies/new' do
        erb :'movies/new'
    end

    get '/movies/:id' do
        @movie = Movie.find_by_id(params[:id])
        erb :'movies/show'
    end

    post '/movies' do
        movie = Movie.new(params[:movie])

        if movie.save
            redirect '/movies'
        else  
            redirect '/movies/new'
        end
    end
end
