class ProductsController < ApplicationController

  def index
    # @product = Product.all.includes(:images)
    # @product = Product.includes(:images)
    @product = Product.all
    # @product = Product.find_by(id: 1)
    # @image = Image.includes(:product)
    # binding.pry
    # @image = Image.new(product_params)
  end

  def new
    @product = Product.new
    @product.images.new
    # @parents = Category.all.order("id ASC").limit()
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      binding.pry
      render :new
    end
  end

  def edit
  end
  
  def update
  end

  def show
    # @product = product.find(params[:id])
  end

  def destroy
  end

  def confirm
  end

  def top
  end

private

  def product_params
    params.require(:product).permit(
      :pname, :explanation, 
      :status, :size_id, 
      :category_id, :brand_id, 
      :shipping_status, :deliver, 
      :prefecture, :shipping_dates, 
      :price, 
      images_attributes: [:id,:image]).merge(user_id: current_user.id)
  end
end
