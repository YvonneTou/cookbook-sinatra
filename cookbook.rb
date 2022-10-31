require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def update_recipe
    save_csv
  end

  private

  # the csv file can be loaded using a private method
  # by creating a load_csv method
  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      complete_boolean = row[4] == 'true'
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], complete_boolean)
    end
  end

  # also save_csv method for rewriting the csv file
  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |recipe|
        complete_status = recipe.complete? == true ? 'true' : 'false'
        # p complete_status
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, complete_status]
      end
    end
  end
  # cookbook = Cookbook.new('lib/recipes.csv')
  # cookbook.save_csv
end
