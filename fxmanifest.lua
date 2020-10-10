fx_version 'adamant'
games { 'rdr3', 'gta5' }
ui_page('html/index.html') --THIS IS IMPORTENT
files {
	"html/index.html",
	"html/libraries/axios.min.js",
	"html/libraries/vue.min.js",
	"html/libraries/vuetify.css",
	"html/libraries/vuetify.js",
	"html/libraries/loading-bar.js",
	
	"html/script.js",
	"html/assets/*",
	"html/style.css"
}

client_scripts {
	"@_core/libs/utils.lua",
	'client.lua',
}

server_scripts {
	"@_core/libs/utils.lua",
	'server.lua'
}