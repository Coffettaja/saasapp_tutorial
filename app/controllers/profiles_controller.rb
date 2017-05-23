class ProfilesController < ApplicationController
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
         redirect_to user_path(params[:user_id])
      else
         # Doesn't make related http request, only shows the view file
         render action :new
      end
   end
   
   private
      #Whitelisted profile field params
      def profile_params
         params.require(:profile).permit(:first_name, :last_name, :sex, 
         :phone_number, :contact_email, :description)
      end
end