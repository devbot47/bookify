class WorkshopsController < ApplicationController

  def index
    @workshops = Workshop.all
  end

  def show
    @workshop = Workshop.friendly.find(params[:id])
  end

end