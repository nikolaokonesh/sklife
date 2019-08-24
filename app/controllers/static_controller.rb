class StaticController < ApplicationController
  layout 'root/index'
  def show
    render params[:page]
  end
end
