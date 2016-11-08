namespace :interview_tasks do
  desc 'This task is used to remove duplicate users from the User model by checking for duplicate email ids'
  task clean_duplicate_users: :environment do
  	User.transaction do
	  	User.select(:id, :email).group(:email).having("count(*) > 1").each do |user|
	  		begin
	  			user.destroy
	  		rescue => error
	  			Rails.logger.error 'Error deleting duplicate user'
	  			Rails.logger.error error.message
	  		end
	  	end
	 end
	 Rails.logger.info 'Clean duplicate users task has been completed'
  end

  desc 'This task is used to load CSV files containing information of materials and workers for each seed project from root of the application into DB'
  task load_csv_files: :environment do

  	require 'csv'

  	employee_projects_csv_path = Rails.root.join('Employees_projects.csv')
  	materials_csv_path         = Rails.root.join('materials.csv')
  	Project.transaction do
	  	CSV.foreach(employee_projects_csv_path, headers: true) do |row|
	  		row_hash = row.to_hash
	  		user     = User.where(:name => row_hash['Employee']).first
	  		project  = Project.where(:name => row_hash['Project']).first
	  		if project.present? and user.present?
	  			project.employees << user
	  			Rails.logger.info "User - #{user.id} / #{user.name} / #{user.email} has been added to project #{project.name}"
	  			project.save
	  		else 
	  			Rails.logger.info "Project not found in DB from row -> #{row}" if project.blank?
	  			Rails.logger.info "User not found in DB from row -> #{row}"    if user.blank?
	  		end
	  	end
	end
  	CSV.foreach(materials_csv_path, headers: true) do |row|
  		row_hash = row.to_hash
  		amount   = row_hash['Amount']
  		quantity = amount.to_i
  		unit     = amount[quantity.to_s.size..-1]

  		material          = Material.where(:name => row_hash['Material']).first
  		material          = Material.create(:name => row_hash['Material']) if material.blank?
  		material.quantity = quantity
  		material.unit     = unit if unit.present?
  		material.save

  		project  = Project.where(:name => row_hash['Project']).first

  		if project.present? and material.present?
  			project.materials << material
  			Rails.logger.info "Material - #{material.id} / #{material.name} has been added to project #{project.name}"
  			project.save
  		else 
  			Rails.logger.info "Project not found in DB from row -> #{row}"  if project.blank?
  			Rails.logger.info "Material not found in DB from row -> #{row}" if material.blank?
  		end

  	end
  end

end
