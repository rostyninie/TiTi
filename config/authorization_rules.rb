authorization do
  role :admin do
    has_permission_on [:commandes], :to => [:index, :commande_recu_pdf, :new, :create, :edit, :update, :list,:solde_commande,:recherche_commande,:destroy,:delete]
    has_permission_on [:achats], :to => [:index, :achat_history, :new, :create, :edit, :update, :seach_product,:recherche_achat,:destroy,:delete]
    has_permission_on [:categorie_droits], :to => [:index, :new, :create, :edit, :update,:destroy,:delete]
    has_permission_on [:categories], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_category,:view,:delete_droit,:delete]
    has_permission_on [:clients], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_client,:delete]
    has_permission_on [:options], :to => [:new,:index]
    has_permission_on [:droits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_droit,:delete]
    has_permission_on [:factures], :to => [:index, :new, :create, :edit, :update,:destroy,:delete]
    has_permission_on [:fournisseurs], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_fournisseur,:delete]
    has_permission_on [:groupes], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_groupe,:delete,:view,:create2,:delete_categorie]
    has_permission_on [:produits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_produit,:delete]
    has_permission_on [:rayons], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_rayon,:delete]
    has_permission_on [:type_produits], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_type_produit,:delete]
    has_permission_on [:users], :to => [:index, :new, :create, :edit, :update,:destroy,:new_password,:delete,:login,:set_new_password]
  end
  
  role :vente_controle do
    has_permission_on [:commandes], :to => [:index, :commande_recu_pdf, :new, :create, :edit, :update, :list,:solde_commande,:recherche_commande,:destroy,:delete]
  end
  
  role :vente_view do
    has_permission_on [:commandes], :to => [:commande_recu_pdf, :new, :list,:recherche_commande]
  end
  
  role :achat_controle do
    has_permission_on [:achats], :to => [:index, :achat_history, :new, :create, :edit, :update, :seach_product,:recherche_achat,:destroy,:delete]
  end
  
  role :achat_view do
    has_permission_on [:achats], :to => [:index, :achat_history,:recherche_achat]
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
    has_permission_on [:fournisseurs], :to => [:index, :new, :create, :edit, :update,:destroy,:recherche_fournisseur,:delete]
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
  
  
  
end