module Api::V1
  class ConvenienceLinksController < ApplicationController
  before_action :set_convenience_link, only: [:show, :edit, :update, :destroy]

  # GET /convenience_links
  def index
    @convenience_links = ConvenienceLink.all.order(created_at: :desc)
    render json: @convenience_links
  end

  # GET /convenience_links/1
  def show
  end

  # GET /convenience_links/1/edit
  def edit
  end

  # POST /convenience_links
  def create
    @convenience_link = ConvenienceLink.new(convenience_link_params)

    if @convenience_link.save
      render json: @convenience_link, status: :created
    else
      render json: @convenience_link.errors, status: :unprocessable_entity
      @user.errors.full_messages.each do |e|
        puts e
      end
    end
  end

  # PATCH/PUT /convenience_links/1
  def update
    if @convenience_link.update(convenience_link_params)
      redirect_to @convenience_link, notice: 'Convenience link was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /convenience_links/1
  def destroy
    @convenience_link.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_convenience_link
      @convenience_link = ConvenienceLink.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def convenience_link_params
      params.require(:convenience_link).permit(:name, :description, :link, :is_public)
    end
end
end
