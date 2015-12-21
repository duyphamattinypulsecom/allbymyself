class User < ActiveRecord::Base
    has_secure_password

    validates :email, :name, presence: true
    validates_confirmation_of :password
end
