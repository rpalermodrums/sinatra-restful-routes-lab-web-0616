class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    # binding.pry
    @recipe = Recipe.create(params)
    redirect to "recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    # binding.pry
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    # binding.pry
    name, ingredients, cook_time =
      params[:name], params[:ingredients], params[:cook_time]
    @recipe = Recipe.find(params[:id])
    @recipe.update(name: name, ingredients: ingredients, cook_time: cook_time)
    redirect to "/recipes/#{@recipe.id}"

  end
end
