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
      @profile = @user.build_profile( profile_params )
      if @profile.save
         flash[:success] = "Profile updated!"
         redirect_to root_path
      else
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