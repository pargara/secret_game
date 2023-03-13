class Game < ApplicationRecord
  validates :year, presence: { message: 'El año de juego no puede ser vacio' }
  validates :year, inclusion: { in: (2023..2032), message: "%{value} no es un valor correcto, tiene
                                que estar entre 2023 y 2032" }
  validate :min_employees

  private

  def min_employees
    errors.add(:base, 'Deben haber al menos 2 empleados') if Employee.count < 2
  end
end
