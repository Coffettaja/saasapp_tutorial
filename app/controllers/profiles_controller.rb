class ProfilesController < ApplicationController
   # Run this devise method before any action is run, is the user logged in?
   before_action :authenticate_user! #, only: [:new, :edit] # for specifying
   before_action :only_current_user
   
   # Will call app/views/profiles/new.html.erb
   def new
       @profile = Profile.new
   end
   
   # POST from new profile -form
   def create
      # Get the user who is filling out the form
      @user = User.find(params[:user_id])
      # Profile link to this specific user
      # 'build_something' is rails built in function; 
      # use when dealing with relations (instead of .new)
      # If the relation was 'has_many', use plural: @user.profiles.build
      @profile = @user.build_profile( profile_params )
      if @profile.save
         flash[:success] = "Profile updated!"
         redirect_to user_path(id: params[:user_id])
      else
         # Doesn't make related http request, only shows the view file
         render action :new
      end
   end
   
   # GET to /users/:user_id/profile/edit
   def edit
      # The profile to be edited
      @profile = User.find( params[:user_id] ).profile
   end
   
   # PUT or PATCH to /users/:user_id/profile
   def update
      @profile = User.find( params[:user_id] ).profile
      
      # Mass assign edited profile attributes and save
      if @profile.update_attributes(profile_params)
         flash[:success] = "Profile updated"
         # Redirect user to their profile page
         redirect_to user_path( id: params[:user_id] )
      else
         render action :edit
      end
   end
   
   private
      #Whitelisted profile field params
      def profile_params
         params.require(:profile).permit(:first_name, :last_name, :avatar, :sex, 
         :phone_number, :contact_email, :description)
      end
      
      # Check if the page that the user is trying to visi actually 'belongs' to them
      # If not, redirect to home page
      def only_current_user
         @user = User.find( params[:user_id] )
         redirect_to(root_url) unless @user == current_user 
      end
end