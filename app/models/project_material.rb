class ProjectMaterial < ActiveRecord::Base
	belongs_to :material
	belongs_to :project
end
