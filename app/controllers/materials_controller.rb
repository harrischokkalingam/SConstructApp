class MaterialsController < ApplicationController

  before_action :set_material, :only => [:edit, :show, :update, :destroy]

  def index
    @materials = Material.all.order(:name).paginate(page: params[:page])
  end

  def new
    @material = Material.new
  end

  def create
    Material.create material_params
    flash[:success] = 'Material created successfully'
    redirect_to materials_path
  end

  def update    
    @material.update_attributes material_params
    flash[:success] = 'Material updated successfully'
    redirect_to materials_path
  end

  def destroy
    name = @material.name
    @material.destroy
    flash[:success] = "Material '#{name}' deleted  successfully"
    redirect_to materials_path
  end

  private

  def set_material
    @material  = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit(:name, :description, :quantity, :unit, :dimensions)
  end

end
