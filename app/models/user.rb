class User < ActiveRecord::Base
  belongs_to :groupe
  has_many :achats
  has_many :achat_histories
  has_many :commandes
 # validates_presence_of :compte, :nom, :tel, :date_naissance,:message =>" : Entrez la date de naissance"
  validates_uniqueness_of :compte ,:message =>"Ce compte est déjà utilisé par un utilisateur"
   before_save :set_is_active
  validates_format_of     :compte, :with => /\A[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\Z/i,   :allow_blank=>true,
   :message => "email invalide!!! exp : admin@titi.com"
 validates_format_of     :tel, :with => /\A[0-9]{9}\Z/i,   :allow_blank=>true,
   :message => "téléphone invalide!!! exp : 655206994"
 scope :active,-> { where(is_active: true) }
 before_save :set_first_login
 scope :inactive, -> { where(is_active: false) }
  
#    has_attached_file :photo,
#    #:styles => {:original=> "125x125#"},
#    :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
#    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
#
#  VALID_IMAGE_TYPES = ['image/gif', 'image/png','image/jpeg', 'image/jpg', 'excel/xls']
#Paperclip.options[:content_type_mappings] = { png: "image/pngg" }
#  
#  validates_attachment :photo,
#    :presence => true,
#    :size => { :in => 0..10.megabytes },
#    :content_type => { :content_type => VALID_IMAGE_TYPES}
  
#  validates_attachment_content_type :photo, :content_type =>VALID_IMAGE_TYPES,
#    :message=>'les images ne peuvent être que de type : GIF, PNG, JPG',:if=> Proc.new { |p| !p.photo_file_name.blank? }
#  validates_attachment_size :photo, :less_than => 1512000,\
#    :message=>'la taille de l\'image ne doit pas dépasser  1500 KB.',:if=> Proc.new { |p| p.photo_file_name_changed? }
  def set_is_active
    if self.is_active.nil?
      self.is_active=1
    end
    
  end
  
  def set_first_login
    if self.first_login.nil?
      self.first_login=0
    end
    
  end
  
  def full_name
    "#{nom} #{prenom}"
  end
  
  def role_symbols
 gc=GroupeCategorie.find_all_by_groupe_id(groupe.id)
 categos=[]
 gc.each do |gct|
  categos.push(gct.category)
 end
    categos.map do |role|
    role.nom.underscore.to_sym
  end
end
end
