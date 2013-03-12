class Ability
  include CanCan::Ability
  
  def initialize(user)
   # user ||= User.new # guest user
    can :show, Job
    can :create, Job
    if user != nil
	    if user.role_ids == [1]
	      can :manage, :all
	    else     
	      if user.role_ids == [3]
	        can :read, Job
	        can :create, Job
	        can :create, Jobapp
	        can :update, Job do |job|
	          job.try(:user) == user
	        end
	        can :manage, Jobapp, :job => { :user_id => user.id }
	      end
  	  end
    end
  end
end

