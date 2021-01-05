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
        redirect_if_movie_not_found
        erb :'/movies/edit'
    end

    get '/movies/:id' do
        find_movie
        redirect_if_movie_not_found
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
        redirect_if_movie_not_found
        if @movie.update(params[:movie])
            redirect "/movies/#{@movie.id}"
        else  
            redirect "/movies/#{@movie.id}/edit"
        end
    end

    delete '/movies/:id' do
        find_movie
        @movie.destroy if @movie
        redirect "/movies"
    end

    private
        def find_movie
            @movie = Movie.find_by_id(params[:id])
        end

        def redirect_if_movie_not_found
            redirect "/movies" unless @movie
        end
end
