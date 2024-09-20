class Api::V1::TagsController < ApplicationController
  before_action :authenticate_request

  def index
    tags = Tag.all
    render json: tags, status: :ok
  end

  def show
    tag = Tag.find(params[:id])
    render json: tag, status: :ok
  end

  def create
    tag = Tag.new(tag_params)
    if tag.save
      render json: tag, status: :created
    else
      render json: { errors: tag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    tag = Tag.find(params[:id])
    if tag.update(tag_params)
      render json: tag, status: :ok
    else
      render json: { errors: tag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head :no_content
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
