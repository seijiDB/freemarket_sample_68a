class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # @categoryインスタンス変数を限定しないと100種以上表示されてしまうので、親カテゴリのみを表示するためset_categoryメソッドで限定する
  before_action :limit_category, only: [:new, :create]
  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    binding.pry
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end 

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def limit_category
    @categorys = Category.where('id < 14')
  end  

  def item_params
    params.require(:item)
      .permit(:name, :price, :description, :category_id, :size, :brand, :condition, :shipping_fee, :shipping_method, :shipping_date, :buyer_id, :seller_id)
  end

end
