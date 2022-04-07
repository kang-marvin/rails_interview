class CityData

  def initialize; end

  def fullname(name)
    result = city_names_and_short_form

    result[name.to_sym] || name
  end

  private

  def city_names_and_short_form
    {
      'LA': 'Los Angeles',
      'NYC': 'New York City',
    }
  end
end
