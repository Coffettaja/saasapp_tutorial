module UsersHelper
    def job_title_icon
       if @user.profile.sex == "Male"
           "<i class='fa fa-male'></i>".html_safe
       elsif @user.profile.sex == "Female"
           "<i class='fa fa-female'></i>".html_safe
       end
    end
end