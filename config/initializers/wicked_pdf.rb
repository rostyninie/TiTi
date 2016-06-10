platform=RUBY_PLATFORM
path=""
if platform.include?("i386-mingw32") || platform.include?("x64-mingw32") 
  path= "#{Rails.root}/pdf/wkhtmltopdf.exe"
elsif platform.include?("x86_64-linux")
  path= "usr/local/bin/wkhtmltopdf"
end
WickedPdf.config = {
    #:wkhtmltopdf => '/usr/bin/wkhtmltopdf', #Djike Cyrano j'ai commenté cette ligne car c'est un chemin linux empêchait la génération des pdf
    :exe_path => path,#Djike Cyrano:j'ai ajouté cette ligne qui correspond au chemin sous windows
    :layout => "pdf.html",                           #j'ai aussi ajouté le dossier pdf à l'emplacement indiqué
    :margin => {    :top=> 1,                       #(le dossier vient du repertoir de la version de production)
                    :bottom => 1,
                    :left=> 1,
                    :right => 1},
    :header => {:html => { :template=> 'layouts/pdf_header.html'}},
    :footer => {:html => { :template=> 'layouts/pdf_footer.html'}},
   #:exe_path => 'C:\Program Files\wkhtmltopdf\bin'
}
