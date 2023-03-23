json.data do
  json.id @game.id
  json.parejas @game.couples
  json.empleado_sin_jugar @game.left
  json.año_de_juego @game.year

end
