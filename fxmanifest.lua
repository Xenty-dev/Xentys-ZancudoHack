fx_version 'cerulean'
game 'gta5'

author 'Zenty'
description 'Zentys Fort Zancudo.'
version '1.0.0'

lua54 'yes'

shared_script '@ox_lib/init.lua'

server_scripts {
    'server/update.lua',
}

client_script 'client.lua'
server_script 'server.lua'

files {
    'locales/en.json'
}

exports "ox_lib"
exports "ox_target"

dependencies {
    'ox_lib',
    'ox_target'
}