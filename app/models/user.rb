class User < ActiveRecord::Base

  after_initialize :default_values
  blogs #blogit

  has_many :jobs
  has_many :jobapps
  has_many :assignments
  has_many :roles, :through => :assignments	
  has_many :comments
  has_many :searches
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :lastname, :firstname, :jobapp_ids, :job_ids

  validates_presence_of :email, :lastname, :firstname
  validates_uniqueness_of :email


  def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.firstname = auth.info.first_name
    user.lastname = auth.info.last_name
  end
end

def self.new_with_session(params, session)
  if session["devise.user_attributes"]
    new(session["devise.user_attributes"], without_protection: true) do |user|
      user.attributes = params
      user.valid?
    end
  else
    super
  end
end

def password_required?
  super && provider.blank?
end

def update_with_password(params, *options)
  if encrypted_password.blank?
    update_attributes(params, *options)
  else
    super
  end
end

  private
    def default_values #set default user when sign up to normal_user
      if self.role_ids == []
      self.role_ids = 3
      end
    end

end
