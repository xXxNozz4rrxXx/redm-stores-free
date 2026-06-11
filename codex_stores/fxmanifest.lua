fx_version 'cerulean'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Codex Studios'
description 'Codex Stores - RedM store system powered by codex_core'
version '1.0.3'

lua54 'yes'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    'locales.lua'
}

client_scripts {
    'client/functions.lua',
    'client/client.lua',
    'client/nui.lua'
}

server_scripts {
    'server/*.lua'
}

files {
    'html/**/*'
}

dependency 'codex_core'
