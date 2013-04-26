ActiveAdmin.register User do
	index do
		column :firstname
		column :lastname
		column :email
		column :provider
		column :last_sign_in_ip  
	end
end
