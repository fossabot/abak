class MainController < ApplicationController
  def search
    @movies = Movie.ransack(params[:q]).result(distinct: true)
    @directors = Director.ransack(params[:q]).result(distinct: true)
    respond_to do |format|
      format.html {}
      format.json {
        @movies    = @movies.limit(5)
        @directors = @directors.limit(5)
      }
    end
  end
end
