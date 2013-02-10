class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.get_id_from_title(title)
    find_by_title(title).id
  end
end
