# frozen_string_literal: true

require 'benchmark'

# Job for fetch movies from API
class MoviesFetchJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 0
  sidekiq_options lock: :until_executed, on_conflict: :reject

  def perform(search_term)
    time = Benchmark.measure do
      MoviesApiService.new(keywords: search_term).search
    end

    puts "Fetch time: #{time}"
  end
end
