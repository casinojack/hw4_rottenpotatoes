require 'spec_helper'

describe Movie do
  describe 'getting list of movie ratings' do
    it 'should return a list of available ratings' do
      Movie.all_ratings.should == %w(G PG PG-13 NC-17 R)
    end
  end

  describe 'find a movie id from a title' do
    it 'should return a movie id from a given title' do
      Movie.should_receive(:get_id_from_title)
      Movie.get_id_from_title('Alien')
    end

    it 'should return the correct movie id from a given title' do
      Movie.create!(:title => "Alien", :id => 1)
      Movie.get_id_from_title('Alien').should == 1
    end
  end
end
