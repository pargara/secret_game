# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

areas = Area.create([{ name: 'Tech' }, { name: 'HR' }])
employees = Employee.create ([{ name: 'Sebastian Guevara', area_id: 1 },
                              { name: 'Anderson Valencia', area_id: 1 },
                              { name: 'Jose Gutierrez', area_id: 1 },
                              { name: 'Robin Cardenas', area_id: 1 },
                              { name: 'Juan David Duque Rendon', area_id: 2 }])
game = Game.create(year: 2023)
