class MainController < ApplicationController
  before_action :force_json, only: :search

  def search
    @movies = Movie.ransack(params[:q]).result(distinct: true).limit(5)
    @directors = Director.ransack(params[:q]).result(distinct: true).limit(5)
    #render json: [@movies, @directors]
  end

  private

  def force_json
    request.format = :json
  end
end
