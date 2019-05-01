class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  before_save :assign_role
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :authentication_keys => [:username]
  #attr_accessor :username, :password, :password_confirmation, :remember_me
  
  #validates_inclusion_of :role, in: %w( company_staff admin service_owner), message: "is not recognized in the system"

  #serialize :services, Array

  
  def assign_role
  	self.role = "company_staff" if self.role.nil?
  end

  def admin?
    self.role == "admin"
  end

  def service_owner?
    self.role == "service_owner"
  end

  def company_staff?
    self.role == "company_staff"
  end
  
  def email_required?
	false
  end 
  
  def email_changed?
	false
  end 
  
  def will_save_change_to_email?
  end
end
