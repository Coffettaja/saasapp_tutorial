class Contact < ActiveRecord::Base
    #TODO: Better validations, at least for email
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true
end