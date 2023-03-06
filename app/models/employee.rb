class Employee < ApplicationRecord
  belongs_to :area
  before_save :set_year
  validates :area_id, presence: { message: 'El empleado tiene que estar asociado a un area' }
  validates :name, presence: { message: 'El empleado tiene que tener un nombre' }
  validates :name, length: { minimum: 3, message: 'El nombre debe tener almenos 3 caracteres' }
  validates :name, format: { with: /\A[a-zA-Z ]*$\Z/, message: 'En el nombre solo pueden haber caracteres de a a-Z' }

  private

  def set_year
    self.year_game = Date.today.year
  end
end
