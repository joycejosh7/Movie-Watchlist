class MoviesController < ApplicationController
    get '/movies' do
        @movies = Movie.all 
        erb :'movies/index'
    end

    get '/movies/new' do
        erb :'movies/new'
    end

    get '/movies/:id/edit' do
        find_movie
        erb :'/movies/edit'
    end

    get '/movies/:id' do
        find_movie
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

    patch '/movies/:id' do
        find_movie
        if @movie.update(params[:movie])
            redirect "/movies/#{@movie.id}"
        else  
            redirect "/movies/#{@movie.id}/edit"
        end
      end

    private
        def find_movie
            @movie = Movie.find_by_id(params[:id])
        end
end
