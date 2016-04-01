require 'spec_helper'


describe MoviesController do
     before :each do
        @fake_movie = double('movie')
        @more_fake_movies = double('movies')
        allow(@fake_movie).to receive(:director) {'Some Name'}
        Movie.should_receive(:find).and_return(@fake_movie)
        allow(Movie).to receive(:same_director) {@more_fake_movies}
  end 
        
    describe '#similar' do
        it 'gets the required movie info available to the view' do
            post :similar, {:id => '1'}
            assigns(:movie).should eql(@fake_movie)
        end
        
        #Happy path: the movie has the info
        it 'calls the model method that return the movies with same director' do
            Movie.should_receive(:same_director).and_return(@more_fake_movies)
            post :similar, {:id => '1'}
        end
        
        it 'sets the similar movies info available to the view' do
            allow(Movie).to receive(:same_director) {@more_fake_movies}
            post :similar, {:id => '1'}
            assigns(:movies).should eql(@more_fake_movies)
        end
        
        #Sad path: the movie does not have the info
        it 'redirect to the movie index' do
            @fake_movie.should_receive(:director).and_return(nil)
            @fake_movie.should_receive(:title).and_return('Some Title')
            
            post :similar, {:id => '1'}
            response.should redirect_to movies_path
        end
        
        it 'sets a movie telling the movie has no director info' do
            @fake_movie.should_receive(:director).and_return(nil)
            @fake_movie.should_receive(:title).and_return('Some Title')
            
            post :similar, {:id => '1'}
            notice = "'Some Title' has no director info"
            flash[:notice].should eql(notice)
        end
        
    end
end

