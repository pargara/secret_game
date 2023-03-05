class Area < ApplicationRecord
  has_many :employees

  validates :name, presence: { message: 'El nombre no puede estar vacio' }
  validates :name, length: { minimum: 3, message: 'El nombre debe tener mas de 3 caracteres' }
  validates :name, uniqueness: { message: 'El nombre del area no puede ser repetido' }
  validates :name, format: { with: /\A[a-zA-Z0-9 ]*$\Z/, message: 'En el nombre solo pueden haber caracteres de a a-Z o numeros' }
end
