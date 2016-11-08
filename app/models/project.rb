class Project < ActiveRecord::Base
	
	has_many :project_employees
	has_many :employees, :source => :user, :through => :project_employees
	
	has_many :project_materials
	has_many :materials, :through => :project_materials
end
