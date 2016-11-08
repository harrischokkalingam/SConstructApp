class ProjectsController < ApplicationController

  autocomplete :material, :name, :full => true
  autocomplete :user,     :name, :full => true

  before_action :set_project, :only => [:edit, :update, :show, :destroy, :add_material, :remove_material, :add_worker, :remove_worker]

  def index
    @projects = Project.all.order(:name).paginate(page: params[:page])
  end

  def new
    @project = Project.new
  end

  def create
    Project.create project_params
    flash[:success] = 'Project created successfully'
    redirect_to projects_path
  end

  def update    
    @project.update_attributes project_params
    flash[:success] = 'Project updated successfully'
    redirect_to projects_path
  end

  def destroy
    name = @project.name
    @project.destroy
    flash[:success] = "Project '#{name}' deleted  successfully"
    redirect_to projects_path
  end

  def add_material
    if params[:material_id].present?
      begin
        material = Material.find(params[:material_id])
        if @project.project_materials.where(:material_id => material.id).size > 0
          flash[:warning] = "Material '#{material.name}' already added to project"
        else
          @project.materials << material
          flash[:success] = "Material '#{material.name}' added to project"
        end
      rescue
        flash[:danger] = 'Material not found in database'        
      end
    else
      flash[:danger] = 'Material not specified'
    end
    redirect_to project_path(@project)
  end

  def remove_material
    if params[:material_id].present?
      begin
        material = Material.find(params[:material_id])
        if @project.project_materials.where(:material_id => material.id).size > 0
          @project.project_materials.where(:material_id => material.id).destroy_all
          flash[:warning] = "Material '#{material.name}' has been removed from project"
        else
          flash[:danger] = "Material '#{material.name}' is not present in this project"
        end
      rescue
        flash[:danger] = 'Material not found in database'        
      end
    else
      flash[:danger] = 'Material not specified'
    end
    redirect_to project_path(@project)
  end

  def add_worker
    if params[:worker_id].present?
      begin
        user = User.find(params[:worker_id])
        if @project.project_employees.where(:user_id => user.id).size > 0
          flash[:warning] = "Worker '#{user.name}' already added to project"
        else
          @project.employees << user
          flash[:success] = "Worker '#{user.name}' added to project"
        end
      rescue
        flash[:danger] = 'Worker not found in database'        
      end
    else
      flash[:danger] = 'Worker not specified'
    end
    redirect_to project_path(@project)
  end

  def remove_worker
    if params[:worker_id].present?
      begin
        user = User.find(params[:worker_id])
        if @project.project_employees.where(:user_id => user.id).size > 0
          @project.project_employees.where(:user_id => user.id).destroy_all
          flash[:warning] = "Worker '#{user.name}' has been removed from project"
        else
          flash[:danger] = "Worker '#{user.name}' is not present in this project"
        end
      rescue
        flash[:danger] = 'Worker not found in database'        
      end
    else
      flash[:danger] = 'Worker not specified'
    end
    redirect_to project_path(@project)
  end

  private

  def set_project
  	@project  = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
