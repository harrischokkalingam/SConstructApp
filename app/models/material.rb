class Material < ActiveRecord::Base
	has_many :project_materials
	has_many :projects, :through => :project_materials
end
