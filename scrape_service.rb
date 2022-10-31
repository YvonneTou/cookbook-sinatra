require 'open-uri'
require 'nokogiri'

class ScrapService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.foodnetwork.com/search/#{@keyword}-"
    html_file = URI.open(url).read
    parsed_html = Nokogiri::HTML(html_file)

    recipe_info = []
    # recipes page
    # search each recipe
    # no space between 2 css selectors mean looking for an element that has both selectors in 1 class
    parsed_html.search('.o-RecipeResult.o-ResultCard').first(5).each do |recipe_card|
      # get the name
      name = recipe_card.search('.m-MediaBlock__a-HeadlineText').text.strip
    # get the prep_time
      prep_time = recipe_card.search('.o-RecipeInfo...').text.strip
      # get the rating
      rating = recipe_card.search('.gig-rating...').attribute('title').value.split(' ')[0]
      # get the details page url
      details_url = "https:" + recipe_card.search('.m-MediaBlock__m-Rating a').attribute('href').value
      # scrap the details page
      details_html_file = URI.open(details_url).read
      deatils_parsed_html = Nokogiri::HTML(html_file)
      description = deatils_parsed_html.search('.o-Method__m-Body').text.gsub("\n", " ").squeeze(" ").strip
      # get the description
      recipe_info << {name: name, prep_time: prep_time, rating: rating, url: details_url}
    end
    recipe_info
  end
end
