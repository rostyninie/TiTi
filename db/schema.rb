# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160910101614) do

  create_table "achat_histories", force: true do |t|
    t.string   "code"
    t.float    "prix_achat_unitaire"
    t.float    "marge_brut"
    t.float    "prix_ht"
    t.integer  "quantite"
    t.date     "date_achat"
    t.integer  "user_id"
    t.integer  "produit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "prix_vente"
    t.string   "raison"
    t.float    "cout_achat"
  end

  create_table "achats", force: true do |t|
    t.string   "code"
    t.float    "prix_achat_unitaire"
    t.float    "marge_brut"
    t.float    "prix_ht"
    t.integer  "quantite"
    t.date     "date_achat"
    t.integer  "user_id"
    t.integer  "produit_id"
    t.integer  "fournisseur_id"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "prix_vente"
    t.float    "quantite_stock_av"
    t.integer  "previous_id"
    t.integer  "next_id"
    t.boolean  "is_active"
    t.integer  "etat_stock"
    t.float    "prix_revient"
    t.float    "cout_achat"
    t.integer  "sortie"
  end

  create_table "categori_salaires", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorie_droits", force: true do |t|
    t.integer  "categorie_id"
    t.integer  "droit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.string   "description"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.string   "phone"
    t.string   "address"
    t.integer  "ville"
    t.integer  "pay_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active"
  end

  create_table "commande_produits", force: true do |t|
    t.integer  "commande_id"
    t.integer  "produit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantite"
    t.integer  "achat_id"
    t.float    "remise"
    t.integer  "unique_produit_id"
    t.float    "pu"
  end

  add_index "commande_produits", ["achat_id"], name: "index_commande_produits_on_achat_id", using: :btree
  add_index "commande_produits", ["unique_produit_id"], name: "index_commande_produits_on_unique_produit_id", using: :btree

  create_table "commandes", force: true do |t|
    t.string   "code"
    t.boolean  "en_cour"
    t.integer  "client_id"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "configurations", force: true do |t|
    t.string   "config_k"
    t.string   "config_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coordonne_bancaires", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "coordonne_clients", force: true do |t|
    t.integer  "coordonne_bancaire_id"
    t.integer  "client_id"
    t.string   "valeur"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coordonne_clients", ["client_id"], name: "index_coordonne_clients_on_client_id", using: :btree
  add_index "coordonne_clients", ["coordonne_bancaire_id"], name: "index_coordonne_clients_on_coordonne_bancaire_id", using: :btree

  create_table "coordonne_fournisseurs", force: true do |t|
    t.integer  "coordonne_bancaire_id"
    t.integer  "fournisseur_id"
    t.string   "valeur"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coordonne_fournisseurs", ["coordonne_bancaire_id"], name: "index_coordonne_fournisseurs_on_coordonne_bancaire_id", using: :btree
  add_index "coordonne_fournisseurs", ["fournisseur_id"], name: "index_coordonne_fournisseurs_on_fournisseur_id", using: :btree

  create_table "droits", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active"
    t.integer  "category_id"
  end

  create_table "factures", force: true do |t|
    t.integer  "num"
    t.integer  "commande_id"
    t.integer  "client_id"
    t.float    "montant"
    t.boolean  "is_solde"
    t.date     "date_facture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "versement"
  end

  create_table "fournisseurs", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.string   "phone"
    t.string   "address"
    t.integer  "ville"
    t.integer  "pay_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active"
  end

  create_table "frai_achats", force: true do |t|
    t.string   "description"
    t.float    "montant"
    t.integer  "achat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "frai_achats", ["achat_id"], name: "index_frai_achats_on_achat_id", using: :btree

  create_table "groupe_categories", force: true do |t|
    t.integer  "groupe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "groupe_droits", force: true do |t|
    t.integer  "groupe_id"
    t.integer  "droit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupes", force: true do |t|
    t.string   "nom"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active"
  end

  create_table "mouvement_stocks", force: true do |t|
    t.datetime "date"
    t.string   "type_mouvement"
    t.integer  "achat_id"
    t.integer  "produit_id"
    t.integer  "quantite"
    t.float    "prix_u"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mouvement_stocks", ["achat_id"], name: "index_mouvement_stocks_on_achat_id", using: :btree
  add_index "mouvement_stocks", ["produit_id"], name: "index_mouvement_stocks_on_produit_id", using: :btree

  create_table "options", force: true do |t|
    t.string   "config_key"
    t.string   "config_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pays", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "produits", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.float    "prix_vente"
    t.float    "prix_gros"
    t.integer  "quantite_gros"
    t.integer  "quantite_stock"
    t.string   "unite"
    t.integer  "type_produit_id"
    t.integer  "rayon_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seuil_warning"
    t.integer  "seuil_danger"
    t.string   "mode"
    t.float    "cump"
  end

  create_table "rayons", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "titre"
    t.string   "description"
    t.float    "montant"
    t.integer  "achat_id"
    t.integer  "commande_id"
    t.boolean  "is_deduc"
    t.boolean  "is_add"
    t.date     "date_transaction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["achat_id"], name: "index_transactions_on_achat_id", using: :btree
  add_index "transactions", ["commande_id"], name: "index_transactions_on_commande_id", using: :btree

  create_table "type_produits", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_salaires", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unique_produits", force: true do |t|
    t.integer  "groupe_id"
    t.string   "code"
    t.float    "prix_vente"
    t.boolean  "etat"
    t.float    "remise"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "achat_id"
    t.integer  "produit_id"
  end

  add_index "unique_produits", ["achat_id"], name: "index_unique_produits_on_achat_id", using: :btree
  add_index "unique_produits", ["produit_id"], name: "index_unique_produits_on_produit_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "compte"
    t.string   "nom"
    t.string   "prenom"
    t.string   "tel"
    t.date     "date_naissance"
    t.integer  "groupe_id"
    t.string   "passe"
    t.boolean  "is_active"
    t.string   "photo_content_type"
    t.string   "photo_file_name"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "first_login"
    t.boolean  "is_admin"
    t.integer  "employe_id"
  end

  create_table "valorisations", force: true do |t|
    t.string   "code"
    t.string   "type_valorisation"
    t.integer  "achat_id"
    t.date     "date_debut"
    t.date     "date_fin"
    t.integer  "produit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_initial"
  end

  add_index "valorisations", ["achat_id"], name: "index_valorisations_on_achat_id", using: :btree
  add_index "valorisations", ["produit_id"], name: "index_valorisations_on_produit_id", using: :btree

end
