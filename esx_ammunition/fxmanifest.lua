fx_version 'adamant'
games {'gta5'}
author 'Tasty'
description 'you can buy ammunition'
version '1.0.0'

client_scripts {
	"@es_extended/locale.lua",
	'client/client.lua',
	'config.lua',
}

server_scripts {
	"@es_extended/locale.lua",
	'server/server.lua'
}

dependency 'es_extended'