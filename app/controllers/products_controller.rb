class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit]
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]

  def index
    @product = Product.all.limit(4).order(created_at: :desc)
  end

  def new
    @product = Product.new
    @product.images.new
    # @product.images.build
    # @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    # binding.pry
    @product = Product.create(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end
  
  def update
  end

  def show
  end

  def destroy
  end

  def confirm
  end

  def top
  end

  def search_level2
    respond_to do |format|
      format.html
      format.json
        set_category_level2
    end
  end

  def search_level3
    respond_to do |format|
      format.html
      format.json
        set_category_level3
    end
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
        images_attributes: [:image]).merge(user_id: current_user.id)
  end
  # いいね機能を取り扱った福本さんの方とパラメータの定義が異なる可能性、ひとまずSHOW画面に表示させるための定義、マージ時確認
  def set_product
    @product = Product.find(params[:id])
  end

  # デフォルトで設定するセレクトドロップダウンリストに入れる値(親要素の値)を定義
  def set_category
    @category_level1 = Category.where(ancestry: nil)
  end
  # 子供のカテゴリーを設定、親の名称で検索 => 紐づいた配列を取得
  # コントロール自体はJSONで行う
  def set_category_level2
    @category_level2 = Category.find(params[:level1_id]).children
  end
  # 孫のカテゴリーを設定
  def set_category_level3
    @category_level3 = Category.find("#{params[:level2_id]}").children
  end

end
