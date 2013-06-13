# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end
  
  def carrito_compra_link
    if current_user
  		if current_user.cart_items
  			link_to 'Carrito de Compras ('+current_user.cart_items.to_s+')', buy_view_cart_path, :class => 'no_underline_login'
  		else
  			link_to 'Carrito de Compras', buy_view_cart_path, :class => 'no_underline_login'
  		end
  	else
  		link_to 'Carrito de Compras', buy_view_cart_path, :class => 'no_underline_login'
  	end
  end
end
