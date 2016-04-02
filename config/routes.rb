TiTiNew::Application.routes.draw do
  resources :factures

  resources :options

  resources :configurations

 # get "configuration/new"
 # resources :controllers

  resources :villes

  resources :pays

  resources :users

  resources :type_produits

  resources :rayons

  resources :produits

  resources :fournisseurs

  resources :commandes

  resources :clients

  resources :achats

  resources :categorie_droits

  resources :categories

  resources :groupes

  resources :droits
  
  #resources :configurations

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'users#login'
   #resources :droits, path: '/droits/delete'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'droits/delete/:id', to: 'droits#delete'
  post 'options/new', to: 'options#new'
  get 'droits/recherche_droit/:nom/:id', to: 'droits#recherche_droit'
  get 'categories/delete_droit/:id', to: 'categories#delete_droit'
  get 'categories/delete/:id', to: 'categories#delete'
  get 'categories/view/:id', to: 'categories#view'
  get 'categories/recherche_category/:nom/:id', to: 'categories#recherche_category'
  get 'groupes/delete/:id', to: 'groupes#delete'
  get 'groupes/recherche_groupe/:nom/:id', to: 'groupes#recherche_groupe'
  get 'users/user_by_groupe/:groupe_id/:id', to: 'users#user_by_groupe'
  get 'users/delete/:id', to: 'users#delete'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#login'
  get '/' => 'users#login'
  post '/' => 'users#login'
  post 'users/deconnexion/:id' => 'users#deconnexion'
  post 'users/first_login_change_password/:id' => 'users#first_login_change_password'
  get 'users/set_new_password/:id' => 'users#set_new_password'
  get 'users/verif_admin/:id' => 'users#verif_admin'
  get 'users/new_password/:id' => 'users#new_password'
  get 'fournisseurs/delete/:id', to: 'fournisseurs#delete'
  get 'fournisseurs/recherche_fournisseur/:nom/:etat/:pays/:ville/:id', to: 'fournisseurs#recherche_fournisseur'
  get 'clients/delete/:id', to: 'clients#delete'
  get 'clients/recherche_client/:nom/:etat/:pays/:ville/:id', to: 'clients#recherche_client'
  get 'type_produits/delete/:id', to: 'type_produits#delete'
  get 'type_produits/recherche_type_produit/:nom/:id', to: 'type_produits#recherche_type_produit'
  get 'rayons/delete/:id', to: 'rayons#delete'
  get 'rayons/recherche_rayon/:nom/:id', to: 'rayons#recherche_rayon'
  get 'produits/delete/:id', to: 'produits#delete'
  get 'produits/recherche_produit/:nom/:id', to: 'produits#recherche_produit'
  get 'achats/seach_product/:type_id/:id', to: 'achats#seach_product'
  get 'achats/achat_history/:id', to: 'achats#achat_history'
  get 'commandes/list/:id', to: 'commandes#list'
  post 'commandes/solde_commande/:id', to: 'commandes#solde_commande'
  get 'commandes/commande_recu_pdf/:id/:facture_id', to: 'commandes#commande_recu_pdf'
  get 'users/dashboard/:id', to: 'users#dashboard'
  #get 'application/menu/:id', to: 'application#menu'
    #get ':controller/:action/:id'
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
# match ':controller(/:action(/:id(.:format)))'
 match ':controller/:action/:id', via: [:get, :post]
# match ':controller/:action', via: [:get, :post]
#  connect ':controller/:action'
#  connect ':controller/:action/:id/:id2'
#  connect ':controller/:action/:id.:format'
end
