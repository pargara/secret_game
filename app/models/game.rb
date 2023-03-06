class Game < ApplicationRecord
  validates :year, presence: { message: 'El año de juego no puede ser vacio' }
  validates :year, inclusion: { in: (2023..2032), message: "%{value} no es un valor correcto, tiene
                                que estar entre 2023 y 2032" }
end
