export node_v=8.8.1
export nwjs_v=0.24.4

get_wechat_devtools_v() {
    wcwd_download='https://servicewechat.com/wxa-dev-logic/download_redirect?type=x64&from=mpwiki'
    curl -sD - $wcwd_download | grep -oP --color=never '(?<=wechat_devtools_)[\d\.]+(?=_x64\.exe)'
}

export version=$(get_wechat_devtools_v) 
