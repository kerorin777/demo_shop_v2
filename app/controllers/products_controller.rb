class ProductsController < ApplicationController
  def index
    @category = params[:category]

    @products = Product.all.order(:id)

    case @category
    when "earring"
      @products = @products.where(category: "earring")
    when "ring"
      @products = @products.where(category: "ring")
    # 何も指定されてないときは全部表示
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
