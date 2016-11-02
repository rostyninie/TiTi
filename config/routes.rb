TiTiNew::Application.routes.draw do
  resources :mouvement_stocks

  get "statistique/index"
  get "statistique/index_bilan"
  get "statistique/index_analyse"
  resources :transactions

  resources :categori_salaires

  resources :coordonne_bancaires

  resources :factures

  resources :options

  resources :configurations

  # get "configuration/new"
  # resources :controllers

  resources :villes

  resources :pays

  resources :users do
    post 'dashboard', on: :collection
    get 'dashboard', on: :collection
    post 'user_by_groupe', on: :collection
  end

  resources :type_produits

  resources :rayons

  resources :produits

  resources :fournisseurs do
    
    post 'recherche_fournisseur', on: :collection
    get 'coordonne_bancaires', on: :collection
    post 'coordonne_bancaires', on: :collection
    post 'delete_coordonne', on: :collection
    get 'delete_coordonne', on: :collection
    post 'update_coordonne', on: :collection
    get 'update_coordonne', on: :collection
    post 'save_value_cood', on: :collection
    get 'save_value_cood', on: :collection
  end

  resources :commandes do
    get 'list', on: :collection
  end

  resources :clients do
    post 'recherche_client', on: :collection
  end

  resources :achats do 
    post 'list_achat_pdf', on: :collection
    get 'list_achat_pdf', on: :collection
    post 'achat_history_pdf', on: :collection
    get 'achat_history_pdf', on: :collection
  end

  resources :categorie_droits

  resources :categories do
    post 'recherche_category', on: :collection
  end

  resources :groupes do
    post 'view', on: :collection
    get 'view', on: :collection
  end

  resources :droits do
    post 'recherche_droit', on: :collection
  end
  
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
  #get 'droits/recherche_droit/:nom/:id', to: 'droits#recherche_droit'
  get 'categories/delete_droit/:id', to: 'categories#delete_droit'
  get 'categories/delete/:id', to: 'categories#delete'
  get 'categories/view/:id', to: 'categories#view'
  #post 'categories/recherche_category', to: 'categories#recherche_category'
  get 'groupes/delete/:id', to: 'groupes#delete'
  get 'groupes/view/:id', to: 'groupes#view'
  post 'groupes/view/:id', to: 'groupes#view'
  post 'groupes/recherche_groupe', to: 'groupes#recherche_groupe'
  #get 'users/user_by_groupe/:groupe_id/:id', to: 'users#user_by_groupe'
  get 'users/delete/:id', to: 'users#delete'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#login'
  get '/' => 'users#login'
  post '/' => 'users#login'
  post 'users/deconnexion/:id' => 'users#deconnexion'
  post 'users/first_login_change_password/:id' => 'users#first_login_change_password'
  get 'users/set_new_password/:id' => 'users#set_new_password'
  post 'users/verif_admin' => 'users#verif_admin'
  post 'users/new_password' => 'users#new_password'
  get 'fournisseurs/delete/:id', to: 'fournisseurs#delete'
  #get 'fournisseurs/recherche_fournisseur/:nom/:etat/:pays/:ville/:id', to: 'fournisseurs#recherche_fournisseur'
  get 'clients/delete/:id', to: 'clients#delete'
  # get 'clients/recherche_client/:nom/:etat/:pays/:ville/:id', to: 'clients#recherche_client'
  get 'type_produits/delete/:id', to: 'type_produits#delete'
  post 'type_produits/recherche_type_produit', to: 'type_produits#recherche_type_produit'
  get 'rayons/delete/:id', to: 'rayons#delete'
  post 'rayons/recherche_rayon', to: 'rayons#recherche_rayon'
  get 'produits/delete/:id', to: 'produits#delete'
  post 'produits/recherche_produit', to: 'produits#recherche_produit'
  post 'achats/seach_product', to: 'achats#seach_product'
  get 'achats/achat_history/:id', to: 'achats#achat_history'
  #get 'commandes/list', to: 'commandes#list'
  post 'commandes/solde_commande/:id', to: 'commandes#solde_commande'
  get 'commandes/commande_recu_pdf/:id/:facture_id', to: 'commandes#commande_recu_pdf'
  post 'commandes/recherche_commande', to: 'commandes#recherche_commande'
   
  post 'achats/active_app/:id', to: 'achats#active_app'
  post 'achats/change_app/:id', to: 'achats#change_app'
  
  post 'achats/add_unique_produit/:id/:id2', to: 'achats#add_unique_produit'
  get 'achats/update_unique/:id', to: 'achats#update_unique'
  post 'achats/edit_unique/:id', to: 'achats#edit_unique'
  post 'achats/delete_unique/:id', to: 'achats#delete_unique'
  post 'achats/destroy_unique/:id', to: 'achats#destroy_unique'
  post 'achats/create_unique', to: 'achats#create_unique'
  post 'achats/faire_sortir', to: 'achats#faire_sortir'
  post 'achats/frais_app/:id', to: 'achats#frais_app'
  get 'achats/frais_app/:id', to: 'achats#frais_app'
  post 'achats/create_frais', to: 'achats#create_frais'
  get 'achats/create_frais', to: 'achats#create_frais'
  post 'achats/update_frais', to: 'achats#update_frais'
  get 'achats/update_frais', to: 'achats#update_frais'
  post 'achats/destroy_frais', to: 'achats#desstroy_frais'
  get 'achats/destroy_frais', to: 'achats#destroy_frais'
  post 'achats/edit_frais', to: 'achats#edit_frais'
  get 'achats/edit_frais', to: 'achats#edit_frais'
   post 'achats/delete_frais', to: 'achats#delete_frais'
  get 'achats/delete_frais', to: 'achats#delete_frais'
  # post 'achats/list_achat_pdf', to: 'achats#list_achat_pdf'
  get 'commandes/list_produit/:id', to: 'commandes#list_produit'
  get 'coordonne_bancaires/delete/:id', to: 'coordonne_bancaires#delete'
  post 'coordonne_bancaires/delete/:id', to: 'coordonne_bancaires#delete'
  post 'coordonne_bancaires/recherche_coordonne', to: 'coordonne_bancaires#recherche_coordonne'
  
  get "statistique/index"
  get "statistique/index_bilan"
  get "statistique/index_analyse"
  get "statistique/bilan_by_periode"
  post "statistique/recherche_transaction"
  get "statistique/valorisation_entree"
  post "statistique/valorisation_entree"
  get "statistique/valoriser"
  post "statistique/valoriser"
  get "statistique/list_stock_initiales"
  post "statistique/list_stock_initiales"
  get "statistique/list_valorisation"
  post "statistique/list_valorisation"
  get "statistique/valide_valorisation"
  post "statistique/valide_valorisation"
  get "statistique/view_valorisation"
  post "statistique/view_valorisation"
  get "statistique/recherche_valorisation"
  post "statistique/recherche_valorisation"
  get "statistique/print_valorisation_pdf"
  post "statistique/print_valorisation_pdf"
  get "statistique/valorisation_periode"
  post "statistique/valorisation_periode"
  get "statistique/list_stock_initiales_periode"
  post "statistique/list_stock_initiales_periode"
  get "statistique/valoriser_periode"
  post "statistique/valoriser_periode"
   get "statistique/print_valorisation_periode_pdf"
  post "statistique/print_valorisation_periode_pdf"
   get "statistique/view_valorisation_periode"
  post "statistique/view_valorisation_periode"
  #post 'users/dashboard', to: 'users#dashboard'
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
  get ':controller(/:action(/:id))' 
  post ':controller(/:action(/:id(/id2)))' 
  #match ':controller/:action/:id', via: [:get, :post]
  # match ':controller/:action', via: [:get, :post]
  #  connect ':controller/:action'
  #  connect ':controller/:action/:id/:id2'
  #  connect ':controller/:action/:id.:format'
end
