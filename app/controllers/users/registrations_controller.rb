class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  
  # Extend Devise so that user signing up for pro plan gets saved
  # with special Stripe subscription function
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
  
  private
  #TODO This should redirect specifically to the plan selection
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
      flash[:notice] = "Select membership plan to sign up."
      redirect_to root_url
      end
    end
end