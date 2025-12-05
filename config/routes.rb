Rails.application.routes.draw do
  # エントランス
  root "home#entrance"

  # 商品ページ（/products と /products/:id）
  resources :products, only: [:index, :show]

  # お知らせ・会社情報・お問い合わせ
  get "news",    to: "news#index"
  get "company", to: "pages#company"
  get "contact", to: "pages#contact"

  # カート
  get  "cart",                     to: "cart#index",  as: :cart
  post "cart/add/:product_id",    to: "cart#add",    as: :add_to_cart
  post "cart/remove/:product_id", to: "cart#remove", as: :remove_from_cart
  post "cart/clear",              to: "cart#clear",  as: :clear_cart
end
