module ApplicationHelper
	def material_unit_quantized(material)
		if material.quantity.present?
			if material.quantity > 0
				((material.unit.present? and material.unit.size > 0) ? material.unit : 'units').pluralize
			else
				((material.unit.present? and material.unit.size > 0) ? material.unit : 'unit').singularize
			end
		else
			((material.unit.present? and material.unit.size > 0) ? material.unit : 'unit').singularize
		end
	end
end
