fx_version 'adamant'
game 'gta5'

 
version '1.0.4'

ui_page 'nui/darkside.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'hansolo/hansolo.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'skywalker.lua'
}

files {
	'nui/darkside.html',
	'nui/lightsaber.js',
	'nui/theforce.css',
	-- 'nui/**/*'
}