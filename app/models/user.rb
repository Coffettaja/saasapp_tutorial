class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  
  attr_accessor :stripe_card_token #Has to be whitelisted before use
  def save_with_subscription
    if valid? #The hell happens here? Parameters, double semicolon, capitalization?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id #This is the token for the customer, not the credit card!
      save!
    end
  end
end
