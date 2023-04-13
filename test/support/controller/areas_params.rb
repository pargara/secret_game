module AreasParams
  def area_params
    { area: { name: 'product' } }
  end

  def invalid_area_params
    { area: { name: '####' } }
  end

  def create_area_valid_keys
    %w[id name]
  end
end
