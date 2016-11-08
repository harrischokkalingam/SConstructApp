class User < ActiveRecord::Base

  has_many :project_employees
  has_many :projects, :through => :project_employees

  validates :name, :email, presence: true
end
