class ViewsController < ApplicationController
  before_action :set_link, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @link.increment!

    redirect_to @link.url, allow_other_host: true
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def record_not_found
    redirect_to root_path, alert: 'Link not found'
  end
end
