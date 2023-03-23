json.data do
  json.array! @employees do |employee|
    json.id employee.id
    json.name employee.name
    json.location employee.area.name
    json.year_created employee.year_game
  end
end
