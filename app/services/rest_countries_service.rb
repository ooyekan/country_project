# app/services/rest_countries_service.rb

require 'httparty'

class RestCountriesService
  include HTTParty
  base_uri 'https://restcountries.com/v3.1'

  def self.all_countries
    response = get('/all')
    if response.success?
      response.parsed_response
    else
      []
    end
  end

  def self.find_country_by_full_name(name)
    country_name = URI.encode_www_form_component(name)
    url = "/name/#{country_name}?fullText=true"
    puts "Request URL: #{base_uri}#{url}"
    response = get(url)
    if response.success? && response.parsed_response.present?
      response.parsed_response[0]
    else
      nil
    end
  end

def self.search_countries(query)
  search_query = URI.encode_www_form_component(query)
  response = get("/name/#{search_query}")
  if response.success?
    response.parsed_response
  else
    []
  end
end

def self.search_by_region(region)
  search_region = URI.encode_www_form_component(region)
  response = get("/region/#{search_region}")
  if response.success?
    response.parsed_response
  else
    []
  end
end

def self.search_countries_in_region(query, region)
  search_query = URI.encode_www_form_component(query)
  search_region = URI.encode_www_form_component(region)
  response = get("/region/#{search_region}")
  if response.success?
    countries_in_region = response.parsed_response
    filtered_countries = countries_in_region.select do |country|
      country['name']['common'].downcase.include?(search_query.downcase) ||
      country['name']['official'].downcase.include?(search_query.downcase)
    end
    if filtered_countries.empty?
      { error: 'Country not found in the specified region' }
    else
      filtered_countries
    end
  else
    []
  end
end
end
