class LinksController < ApplicationController
  def index
    @links = Link.all.order(created_at: :desc)
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to root_path, notice: 'Link created successfully'
    else
      index # runs the code inside the index action, aslong as index does not call render or redirect
      render :index, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :description, :image)
  end
end
