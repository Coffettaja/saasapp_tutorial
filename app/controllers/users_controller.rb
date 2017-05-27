class UsersController < ApplicationController
   # Run this devise method before any action is run, is the user logged in?
   before_action :authenticate_user!
   
   def index
      @users = User.includes(:profile) # Combines users and profiles in one query
   end
   
   # GET to /users/:id
   # Use 'show' to show individual resource
   def show
       @user = User.find(params[:id])
   end
end