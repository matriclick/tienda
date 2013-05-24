pdf.line_width = 15
pdf.stroke_color = "777777"
pdf.stroke_horizontal_line 0, 545
pdf.line_width = 1

define_grid(:columns => 4, :rows => 6, :gutter => 10)

grid([0,0], [0,1]).bounding_box do
	pdf.move_down(10)
	pdf.image "#{Rails.root}/app/assets/images/logo_matri.png", :width => 150, :at => [20, cursor - 15]
end

grid([1,0], [1,3]).bounding_box do
	pdf.stroke_horizontal_rule
	pdf.font_size 16
	pdf.fill_color = "000000"
	pad(20) {
		pdf.text "Gift Card válida por #{number_to_currency @gift_card.value}" +
		" en #{@gift_card.supplier_account.fantasy_name}", :align => :center
		pdf.move_down(10)
		pdf.font_size 12
		pdf.text "Código Gift Card ##{@gift_card_code.code}", :align => :center
	}
	pdf.stroke_horizontal_rule
end

pdf.move_down(50)

grid([2,0], [3,1]).bounding_box do
	indent 20 do
		pdf.fill_color = "000000"
		pdf.text "Proveedor: #{@gift_card.supplier_account.fantasy_name}", :style => :bold
		pdf.fill_color = "777777"
		pdf.move_down(5)
		pdf.image "#{Rails.root}/public#{@gift_card.supplier_image}"
		pdf.move_down(5)
		font_size(10) {
			pdf.text "#{@gift_card.supplier_account.address.get_address if !@gift_card.supplier_account.address.nil?}"
			pdf.move_down(5)
			pdf.text "#{@gift_card.supplier_account.phone_number if !@gift_card.supplier_account.phone_number.nil?}"
			pdf.move_down(5)
			pdf.text "#{@gift_card.supplier_account.web_page if !@gift_card.supplier_account.web_page.nil?}"
			pdf.move_down(5)
			pdf.text "#{@gift_card.supplier_account.supplier.email if !@gift_card.supplier_account.supplier.email.nil?}"
		}
	end
end

grid([2,2], [3,3]).bounding_box do
	indent 20 do
		pdf.fill_color = "000000"
		pdf.text "Condiciones", :style => :bold
		pdf.move_down(10)
		pdf.fill_color = "777777"
		font_size(10) {
			if @gift_card.applies_to_range
				pdf.text "Aplica para vestidos entre #{number_to_currency @gift_card.min_price} y #{number_to_currency @gift_card.max_price}"
				pdf.move_down(5)
				pdf.text "y para los vestidos seleccionados en el detalle"
			else
				pdf.text "Aplica para los vestidos seleccionados en el detalle"
			end
			pdf.move_down(10)
			pdf.text "Canje válido desde el #{@gift_card.valid_from.strftime("%d %b %Y")} hasta el #{@gift_card.valid_to.strftime("%d %b %Y")}"
			pdf.move_down(10)
			pdf.text "Gift Cards no acumulables para el mismo producto"
		}	
	end
end
pdf.stroke_horizontal_rule
grid([4,0], [5,3]).bounding_box do
	
	indent 20 do
		pdf.fill_color = "000000"
		pdf.text "Cómo usar la Gift Card Matriclick:"
		pdf.fill_color = "777777"
		pdf.move_down(10)
		font_size(11) {
			pdf.text "(1) Imprime la Gift Card          (2) Preséntala en la tienda          (3) ¡Vístete de Gala!", :align => :center
		}
	end
	pdf.move_down(30)
	indent 20 do
		font_size(10) {
			pdf.text "¿Dudas? Contáctanos:"
			pdf.move_down(5)
			indent(5) { 
				pdf.text "- Correo Soporte Matriclick: hola@matriclick.com"
				pdf.move_down(3)
				pdf.text "- Soporte al cliente Matriclick: 02 247 8174" 
			}
		}
	end
end
pdf.line_width = 15
pdf.stroke_color = "777777"
pdf.stroke_horizontal_line 0, 545