class MoviesController < ApplicationController
    get '/movies' do
        redirect_if_not_logged_in  
        @movies = current_user.movies
        @movie = Movie.find_by_id(session[:movie_id])
        erb :'movies/index'
    end

    get '/movies/new' do
        redirect_if_not_logged_in
        erb :'movies/new'
    end

    get '/movies/:id/edit' do
        redirect_if_not_logged_in
        find_movie
        redirect_if_movie_not_found
        redirect_if_not_owner
        erb :'/movies/edit'
    end

    get '/movies/:id' do
        redirect_if_not_logged_in
        find_movie
        redirect_if_movie_not_found
        redirect_if_not_owner
        session[:movie_id] = @movie.id if @movie 
        erb :'movies/show'
    end

    post '/movies' do
        movie = current_user.movies.build(params[:movie])
        if movie.save
            redirect '/movies'
        else  
            flash[:errors] = movie.errors.full_messages
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
        redirect_if_movie_not_found
        redirect_if_not_owner
        @movie.destroy
        redirect "/movies"
    end

    private
        def find_movie
            @movie = Movie.find_by_id(params[:id])
        end

        def redirect_if_movie_not_found
            redirect "/movies" unless @movie
        end

        def redirect_if_not_owner
            redirect "/movies" unless @movie.user == current_user
        end
end
