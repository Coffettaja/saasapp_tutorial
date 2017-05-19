class ProfilesController < ApplicationController
   # Will call app/views/profiles/new.html.erb
   def new
       @profile = Profile.new
   end
end