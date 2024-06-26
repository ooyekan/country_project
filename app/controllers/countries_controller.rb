# app/controllers/countries_controller.rb

class CountriesController < ApplicationController
  include HTTParty
  base_uri 'https://restcountries.com/v3.1'

  def index
    @countries = RestCountriesService.all_countries
  rescue StandardError => e
    flash[:alert] = "Error fetching countries: #{e.message}"
    @countries = []
  end

  def show
    encoded_name = params[:name].split(' ').map { |word| URI.encode_www_form_component(word) }.join(' ')
    @country = RestCountriesService.find_country_by_full_name(encoded_name)
    if @country.nil?
      flash[:alert] = 'Country not found'
      redirect_to countries_path
    end
  end

  def search
    @countries = if params[:query].present? && params[:region].present?
                RestCountriesService.search_countries_in_region(params[:query], params[:region])
                 elsif params[:query].present?
                  RestCountriesService.search_countries(params[:query])
                 elsif params[:region].present?
                  RestCountriesService.search_by_region(params[:region])
                 else
                   []
                 end

    if @countries.is_a?(Hash) && @countries[:error]
      flash[:alert] = @countries[:error]
      redirect_to countries_path
    elsif @countries.empty?
      flash[:alert] = 'No countries found for your search'
      redirect_to countries_path
    else
      render :index
    end
  end
end
