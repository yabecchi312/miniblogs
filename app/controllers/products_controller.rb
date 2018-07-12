class ProductsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
    @search = Product.ransack(params[:q])
    @result = @search.result.order("created_at DESC").page(params[:page]).per(5)
    @products = Product.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    Product.create( text: product_params[:text], user_id: current_user.id, title: product_params[:title])
  end

  def destroy
    product = Product.find(params[:id])
    if product.user_id == current_user.id
      product.destroy
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    if product.user_id == current_user.id
      product.update(product_params)
    end
  end

  private
  def product_params
    params.require(:product).permit( :text,:title)
  end

  def move_to_index
    redirect_to :action => "index" unless user_signed_in?
  end
end

