
authorization do
  role :admin do
    has_permission_on [:jobs, :base_urls, :users], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
    has_permission_on :jobs, :to => [:show]
  end
   
  role :normal_user do
    includes :guest
    has_permission_on :jobs, :to => [:new, :create]
    has_permission_on :jobs, :to => [:edit, :update] do
      if_attribute :user => is { user }
    end
  end
end

