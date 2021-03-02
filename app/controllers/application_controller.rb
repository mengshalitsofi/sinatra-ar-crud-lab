
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  post '/articles' do
    article = Article.create(:title => params[:title], :content => params[:content])
    redirect "/articles/#{article.id}"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id/edit' do
    @article = Article.where(:id => params[:id])[0]
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.where(:id => params[:id])[0]
    article.update(:title => params[:title], :content => params[:content])
    redirect "/articles/#{article.id}"
  end

  get '/articles/:id' do
    @article = Article.where(:id => params[:id])[0]
    erb :show
  end

  delete '/articles/:id' do
    article = Article.where(:id => params[:id])[0]
    article.delete
    redirect '/articles'
  end
end
