require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
# cookbook = ['Beer Chicken', 'Banana split', 'Ramen']

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get "/" do
  @cookbook = cookbook.all
  erb :index
end

get "/new" do
  erb :new
end

get "/team/:username" do
  puts params[:username]
  "The username is #{params[:username]}"
end
