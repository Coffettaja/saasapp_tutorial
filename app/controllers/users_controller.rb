class UsersController < ApplicationController
   
   # GET to /users/:id
   # Use 'show' to show individual resource
   def show
       @user = User.find(params[:id])
   end
end