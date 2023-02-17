# frozen_string_literal: true

require 'httpclient'

# This class responsible to process movies list
class MoviesClient
  def initialize(args)
    @keywords = args[:keywords]
    @response_movies = []
  end

  def search
    current_page = 1

    loop do
      response = movie_request(current_page)
      @response_body = JSON.parse(response.body)

      raise RuntimeError unless response.status == 200

      @response_movies.concat(@response_body['results'])
      current_page += 1

      break if current_page > @response_body['total_pages']
    end

    cache_object = SearchResult
                   .create_with(result_hash: @response_movies.to_json)
                   .find_or_create_by!(search_term: @keywords)

    ActionCable.server.broadcast 'MoviesChannel', 'fetched'
  end

  private

  def movie_request(page)
    HTTPClient.new.request(
      :get,
      movie_request_url(page),
      body: {}
    )
  end

  def movie_request_url(page)
    "#{ENV['MOVIES_API_URL']}?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&query=#{@keywords.gsub(' ',
                                                                                                     '%20')}&page=#{page}"
  end
end
