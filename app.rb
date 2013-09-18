
require "sinatra"
require "sinatra/activerecord"

class User < ActiveRecord::Base
end

# heler methods should come here
helpers do
  # helper for link_to,  
  def link_to(url,text=url,opts={})
    attributes = ""
	opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
	"<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end

  # helper for user delete call
  def delete_user_button(user_id)
    erb :_delete_user_button, locals: { user_id: user_id}
  end
end

# root URL for user
get '/' do
  @users = User.all
  erb :'users/index'
end

# Get the New User form
get '/new' do
  @user = User.new
  erb :'users/new'
end

# Create user date and render to user details page(index)
post '/user' do
  User.create(:name => params[:name], :email => params[:email], :desc => params[:desc])
  @users = User.all
  erb :'users/index'
end

# Deletes the user with this ID and redirects to homepage.
delete "/user/:id" do
  @user = User.find(params[:id]).destroy
  redirect "/"
end

 
