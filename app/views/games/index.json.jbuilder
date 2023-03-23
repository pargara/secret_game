json.data do
  json.array! @games do |game|
    json.id game.id
    json.couples game.couples
    json.left game.left
  end
end
