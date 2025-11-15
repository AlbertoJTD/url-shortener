class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]

  def index
    @links = Link.all.includes(:views).order(created_at: :desc)
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Link created successfully' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('links', partial: 'links/link', locals: { link: @link }),
            turbo_stream.replace('link_form', partial: 'links/link_form', locals: { link: Link.new })
          ]
        end
      end
    else
      index # runs the code inside the index action, aslong as index does not call render or redirect
      render :index, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @link.update(link_params)
      redirect_to link_path(@link), notice: 'Link updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path, notice: 'Link deleted successfully'
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :description, :image)
  end

  def set_link
    @link = Link.find(params[:id])
  end
end
