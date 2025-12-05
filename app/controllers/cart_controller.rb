class CartController < ApplicationController
  before_action :load_cart

  # GET /cart
  def index
    # @cart_items と @total は load_cart でセット済み
  end

  # POST /cart/add/:product_id
  def add
    product_id = params[:product_id].to_s

    @cart[product_id] = (@cart[product_id] || 0) + 1
    session[:cart] = @cart

    redirect_back fallback_location: cart_path, notice: "カートに追加しました"
  end

  # POST /cart/remove/:product_id
  def remove
    product_id = params[:product_id].to_s

    if @cart[product_id]
      @cart[product_id] -= 1
      @cart.delete(product_id) if @cart[product_id] <= 0
      session[:cart] = @cart
    end

    redirect_back fallback_location: cart_path, notice: "カートを更新しました"
  end

  # POST /cart/clear
  def clear
    session[:cart] = {}
    redirect_to cart_path, notice: "カートを空にしました"
  end

  private

  def load_cart
    # セッションからカートを取り出し（なければ空ハッシュ）
    session[:cart] ||= {}
    @cart = session[:cart]

    product_ids = @cart.keys

    # ここがポイント：空のときでも必ず @cart_items を配列としてセット
    if product_ids.empty?
      @cart_items = []
      @total = 0
      return
    end

    products = Product.where(id: product_ids)

    @cart_items = products.map do |product|
      quantity = @cart[product.id.to_s] || 0
      subtotal = product.price * quantity

      {
        product: product,
        quantity: quantity,
        subtotal: subtotal
      }
    end

    @total = @cart_items.sum { |item| item[:subtotal] }
  end
end
