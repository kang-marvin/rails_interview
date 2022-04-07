class CityData

  attr_reader :city_short_form

  def initialize(city_short_form = '')
    @city_short_form = city_short_form.to_s
  end

  def full_name
    result = city_names_and_short_form

    result[@city_short_form.to_sym] || @city_short_form
  end

  private

  def city_names_and_short_form
    {
      'LA': 'Los Angeles',
      'NYC': 'New York City',
    }
  end
end
