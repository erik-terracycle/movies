# frozen_string_literal: true

require 'will_paginate/array'

class MoviesController < ApplicationController
  MAX_PER_PAGE = 20

  def index
    flash.clear
    return unless params[:keywords]

    @movies = MoviesClient.new(params[:keywords], flash).movies

    @movies = @movies.paginate(page: params[:page], per_page: MAX_PER_PAGE) unless @movies == 'processing'
  end

  private

  def movie_params
    params.permit(:keywords, :page)
  end
end
