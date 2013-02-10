# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(
      :title => movie[:title],
      :rating => movie[:rating],
      :release_date => movie[:release_date],
      :director => movie[:director],
    )
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2), "#{e1} was found after #{e2}"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
    When %{I #{uncheck}check "ratings_#{rating}"}
  end
end

Then /I should see all of the movies/ do
  page.all("table#movies tbody tr").count.should == Movie.all.count
end

Then /I should not see any movies/ do
  page.all("table#movies tbody tr").count.should == 0
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  assert Movie.find_by_title(movie).director == director, "#{movie}'s director was not #{director}"
end
