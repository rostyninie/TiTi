authorization do
  role :admin do
    has_permission_on [:commandes], :to => [:index, :commande_recu_pdf, :new, :create, :edit, :update, :list,:solde_commande,:recherche_commande,:destroy,:delete,:list_produit]
    has_permission_on [:achats], :to => [:index, :achat_history, :new, :create, :edit, :update, :seach_product,:recherche_achat,:destroy,:delete,:active_app,:change_app,:add_unique_produit,:update_unique,:create_unique,:edit_unique,:delete_unique,:destroy_unique,:list_achat_pdf,:achat_history_pdf,:faire_sortir,:frais_app,:create_frais,:edit_frais,:update_frais,:delete_frais,:destroy_frais]
    has_permission_on [:categorie_droits], :to => [:index, :new, :create, :edit, :update,:destroy,:delete]
    has_permission_on [:categories], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_category,:view,:delete_droit,:delete]
    has_permission_on [:clients], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_client,:delete]
    has_permission_on [:options], :to => [:new,:index]
    has_permission_on [:droits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_droit,:delete]
    has_permission_on [:factures], :to => [:index, :new, :create, :edit, :update,:destroy,:delete]
    has_permission_on [:fournisseurs], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_fournisseur,:delete,:coordonne_bancaires,:delete_coordonne,:update_coordonne,:save_value_cood]
    has_permission_on [:groupes], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_groupe,:delete,:view,:create2,:delete_categorie]
    has_permission_on [:produits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_produit,:delete]
    has_permission_on [:rayons], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_rayon,:delete]
    has_permission_on [:type_produits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_type_produit,:delete]
    has_permission_on [:users], :to => [:index, :new, :create, :edit, :update,:destroy,:new_password,:delete,:login,:set_new_password]
    has_permission_on [:coordonne_bancaires], :to => [:index, :new, :create, :edit, :update,:destroy,:delete,:recherche_coordonne]
    has_permission_on [:statistique], :to => [:index, :index_bilan, :index_analyse, :bilan_by_periode, :recherche_transaction,:valorisation_entree,:valoriser,:list_stock_initiales,:list_valorisation,:valide_valorisation,:view_valorisation,:recherche_valorisation,:print_valorisation_pdf,:valorisation_periode,:list_stock_initiales_periode,:valoriser_periode,:print_valorisation_periode_pdf,:view_valorisation_periode]
  end
  
  role :vente_controle do
    has_permission_on [:commandes], :to => [:index, :commande_recu_pdf, :new, :create, :edit, :update, :list,:solde_commande,:recherche_commande,:destroy,:delete,:list_produit]
  end
  
  role :vente_view do
    has_permission_on [:commandes], :to => [:commande_recu_pdf, :new, :list,:recherche_commande,:list_produit]
  end
  
  role :achat_controle do
    has_permission_on [:achats], :to => [:index, :achat_history, :new, :create, :edit, :update, :seach_product,:recherche_achat,:destroy,:delete,:active_app,:change_app,:add_unique_produit,:update_unique,:create_unique,:edit_unique,:delete_unique,:destroy_unique,:list_achat_pdf,:achat_history_pdf]
  end
  
  role :achat_view do
    has_permission_on [:achats], :to => [:index, :achat_history,:recherche_achat,:list_achat_pdf,:achat_history_pdf]
  end
  
  role :categories_controle do
    has_permission_on [:categories], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_category,:view,:delete_droit,:delete]
  end
  
  role :categories_view do
    has_permission_on [:categories], :to => [:index,:recherche_category,:view]
  end
  
  role :clients_controle do
    has_permission_on [:clients], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_client,:delete]
  end
  
  role :clients_view do
    has_permission_on [:clients], :to => [:index,:recherche_client]
  end
  
  
  role :options_controle do
    has_permission_on [:options], :to => [:new,:index]
  end
  
  
  role :droits_controle do
    has_permission_on [:droits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_droit,:delete]
  end
  
  
  role :factures_controle do
    has_permission_on [:factures], :to => [:index, :new, :create, :edit, :update,:destroy,:delete]
  end
  
  
  role :fournisseurs_controle do
    has_permission_on [:fournisseurs], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_fournisseur,:delete,:coordonne_bancaires,:delete_coordonne,:update_coordonne,:save_value_cood]
  end
  
  role :fournisseurs_view do
    has_permission_on [:fournisseurs], :to => [:index,:recherche_fournisseur]
  end
  
  
  role :groupes_controle do
    has_permission_on [:groupes], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_groupe,:delete,:view,:create2,:delete_categorie]
  end
  
  role :groupes_view do
    has_permission_on [:groupes], :to => [:index,:recherche_groupe,:view]
  end
  
  
  role :produits_controle do
    has_permission_on [:produits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_produit,:delete]
  end
  
  role :produits_view do
    has_permission_on [:produits], :to => [:index,:recherche_produit]
  end
  
  
  role :rayons_controle do
    has_permission_on [:rayons], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_rayon,:delete]
  end
  
  role :rayons_view do
    has_permission_on [:rayons], :to => [:index,:recherche_rayon]
  end
  
  
  role :type_produits_controle do
    has_permission_on [:type_produits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_type_produit,:delete]
  end
  
  role :type_produits_view do
    has_permission_on [:type_produits], :to => [:index,:recherche_type_produit]
  end
  
   role :coordonne_bancaire_controle do
    has_permission_on [:coordonne_bancaires], :to => [:index, :new, :create, :edit, :update,:destroy,:delete,:recherche_coordonne]
  end
  
  
end