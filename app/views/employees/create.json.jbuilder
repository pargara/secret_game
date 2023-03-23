json.data do
  json.id @employee.id
  json.nombre @employee.name
  json.area @employee.area.name
  json.año_en_trabajo @employee.year_game
end
