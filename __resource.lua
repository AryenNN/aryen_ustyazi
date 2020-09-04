-- AryenN tarafından geliştirilmiştir 
-- Developed by AryenN
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description 'AryenN'
ui_page('html/index.html') -- HTML'i içe aktarır
client_scripts {
    'jns_client.lua',
}
server_scripts {
    'jns_server.lua',
}
-- Dosyaları içe aktarır
files({
    'html/index.html',
    'img/logo.png',
    'html/css/style.css',
    'html/css/bootstrap.min.css',
    'html/js/script.js',
    'html/js/bootstrap.min.js'
})
