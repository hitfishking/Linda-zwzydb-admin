Test01Proj::Application.routes.draw do

  get "plant/query_keshu"
  post "plant/query_keshu"
  get "plant/update_keshu"
  post "plant/update_keshu"
  get "plant/delete_keshu"
  post "plant/delete_keshu"
  get "plant/create_keshu"
  post "plant/create_keshu"


	get "plant/send_shu"
	post "plant/send_shu"
	get "plant/send_ke"
	post "plant/send_ke"

  get "plant/zhong_query"
  post "plant/zhong_query"
  get "plant/zhong_update"
  post "plant/zhong_update"
  get "plant/zhong_create"
  post "plant/zhong_create"
  get "plant/zhong_delete"
  post "plant/zhong_delete"

  get "plant/pics_upload"
  post "plant/pics_upload"
  get "plant/pics_query"
  post "plant/pics_query"
  get "plant/pics_delete"
  post "plant/pics_delete"
  get "plant/pics_update"
  post "plant/pics_update"

  #post "plant/recieve_hash"
  #get  "plant/recieve_hash"

  #match 'plant/recieve_hash',:controller => 'plant', :action => 'recieve_hash' , via: [:get,:post]


	# The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
