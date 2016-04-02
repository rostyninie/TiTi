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

ActiveRecord::Schema.define(version: 20160320075238) do

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
    t.integer  "pay_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ville"
    t.boolean  "is_active"
  end

  create_table "commande_produits", force: true do |t|
    t.integer  "commande_id"
    t.integer  "produit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "remise"
    t.integer  "quantite"
  end

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
    t.string   "config_key"
    t.string   "config_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "pay_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ville"
    t.boolean  "is_active"
  end

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
  end

  create_table "rayons", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_produits", force: true do |t|
    t.string   "code"
    t.string   "nom"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

end
