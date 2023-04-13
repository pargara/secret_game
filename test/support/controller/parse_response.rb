module ParseResponse
  def response_body
    JSON.parse(@response.body)
  end

  def length_body
    response_body.length
  end
end
