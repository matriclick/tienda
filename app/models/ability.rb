class Ability
  include CanCan::Ability

  def initialize(resource)
    # Define abilities for the passed in user here. For example:
 		if resource.kind_of? User
				resource ||= User.new # guest user (not logged in)
			    if resource.admin?
			      can :manage, :all
			    else
			      # nothing yet...
			    end
			elsif resource.kind_of? Supplier		
    	can :manage, SupplierAccount, :supplier_id => resource.id
			# can :manage, Presentation, :supplier_id => resource.id
			# can :manage, Product, :supplier_id => resource.id
		end
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
