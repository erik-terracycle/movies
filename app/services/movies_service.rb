# frozen_string_literal: true

require 'movies_client'

# Service to handle movies listing
class MoviesService
  def initialize(search_term, flash)
    @search_term = search_term
    @flash = flash
  end

  def movies
    cache_object = SearchResult.find_by(search_term: @search_term)

    if cache_object && cache_object.created_at > 2.minutes.ago
      fetched_from = cache_object.fetch_count.zero? ? 'API' : 'DB'
      flash[:alert] = "Fetched from #{fetched_from}! Count: #{cache_object.fetch_count}"
      cache_object.increment!(:fetch_count, 1)

      JSON.parse(cache_object.result_hash)

    else
      cache_object&.destroy
      flash[:alert] = 'Processing...'

      movies = MoviesFetchJob.perform_later(@search_term)

      'processing'
    end
  end

  private

  attr_accessor :search_term, :flash
end
