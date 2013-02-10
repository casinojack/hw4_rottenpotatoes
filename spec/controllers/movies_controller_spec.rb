require 'spec_helper'
 
describe MoviesController do
  describe 'finding movies with same director' do
    before :each do
      Movie.stub(:find_by_id).and_return(mock('movie', :director => 'Ridley Scott'))
      @fake_results = [mock('movie1', :id => 1), mock('movie2', :id => 2)]
    end

    it 'should call the model method that returns movies with the same director' do
      Movie.should_receive(:find_all_by_director).with('Ridley Scott').and_return(@fake_results)
      get :filter_by_director, {:id => '1'}
    end

    describe 'after valid search' do
      before :each do
        Movie.stub(:find_all_by_director).and_return(@fake_results)
        get :filter_by_director, {:id => '1'}
      end

      it 'should select the filter_by_director template for rendering' do
        response.should render_template('filter_by_director')
      end

      it 'should make the director search results available to that template' do
        assigns(:movies).should == @fake_results
      end
    end

    describe 'after invalid search' do
      before :each do
        @fake_movie = mock('movie1', :title => 'movie')
        @fake_results = []
        Movie.stub(:find_by_id).and_return(mock('movie', :title => @fake_movie.title, :director => nil))
        Movie.stub(:find_all_by_director).with(nil).and_return(@fake_results)
        get :filter_by_director, {:id => '1'}
      end

      it 'should redirect to the homepage' do
        response.should redirect_to(movies_path)
      end

      it 'should flash that no director was provided' do
        flash[:notice].should == "'#{@fake_movie.title}' has no director info"
      end
    end
  end

  describe 'creating a new movie' do
    it 'should redirect to the homepage' do
      Movie.stub(:create!).and_return(mock('movie', :title => 'title'))
      post :create, {}
      response.should redirect_to(movies_path)
    end
  end

  describe 'deleting a movie' do
    it 'should redirect to the homepage' do
      Movie.stub(:find).and_return(mock('movie', :title => 'title'))
      Movie.stub(:destroy)
      post :destroy, {:id => 1}
      response.should redirect_to(movies_path)
    end
  end
end
