#!/bin/sh

USERNAME="admin"
PASSWORD="pass"
BASE_URL="http://192.168.1.1"
LOGIN_URL="$BASE_URL/login"

WLCFG_URL="$BASE_URL/wlcfg.html"
WL_UPDATE_URL="$BASE_URL/wlcfg.wl"

WANSRVC_URL="$BASE_URL/wansrvc.cmd?wanL2IfName=veip0"
WANSRVC_UPDATE_URL="$BASE_URL/wansrvc.cmd?wanL2IfName=veip0"

PPPOE_URL="$BASE_URL/pppoe.html"
PPPOE_UPDATE_URL="$BASE_URL/pppoe.cgi"

IFCGATEWAY_URL="$BASE_URL/ifcgateway.html"
IFCGATEWAY_UPDATE_URL="$BASE_URL/ifcgateway.cgi"

IFCDNS_URL="$BASE_URL/ifcdns.html"
IFCDNS_UPDATE_URL="$BASE_URL/ifcdns.cgi"

NTWKSUM2_URL="$BASE_URL/ntwksum2.html"
NTWKSUM2_UPDATE_URL="$BASE_URL/ntwksum2.cgi"

WANCFG_URL="$BASE_URL/wancfg.cmd"
WANCFG_UPDATE_URL="$BASE_URL/wancfg.cmd"

WANMAP_URL="$BASE_URL/wanmap.html"
WANMAP_UPDATE_URL="$BASE_URL/wanmap.cgi"

PORT_URL="$BASE_URL/scvrtsrv.html"
PORT_UPDATE_URL="$BASE_URL/scvrtsrv.cmd"

DDNS_URL="$BASE_URL/ddnsadd.html"
DDNS_UPDATE_URL="$BASE_URL/ddnsmngr.cmd"

ROUTE_URL="$BASE_URL/routeadd.html"
ROUTE_UPDATE_URL="$BASE_URL/rtroutecfg.cmd"

#WANPORT_URL="$BASE_URL/wanmgmtac.html"
#WANPORT_UPDATE_URL="$BASE_URL/wanmgmtac.cgi"

# Вход в систему и сохранение cookies
LOGIN_RESPONSE=$(curl -s -c cookies.txt -d "username=$USERNAME&password=$PASSWORD" "$LOGIN_URL")
echo "Login response received."

# Получение страницы настроек Wi-Fi
HTML_TEXT=$(curl -s -b cookies.txt "$WLCFG_URL")
echo "Wi-Fi config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o 'sessionKey=[0-9]*' | sed 's/sessionKey=//')

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"
    
    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$WL_UPDATE_URL?wlSsidIdx=0&wlEnbl=0&wlEnableHspot=0&wlHide=0&wlAPIsolation=0&wlSsid=ELTEX-1FEE&wlCountry=RU&wlSyncNvram=1&sessionKey=$SESSION_KEY")
    echo "Wi-Fi settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi

# Получение страницы настроек WANSRVC_URL
HTML_TEXT=$(curl -s -b cookies.txt "$WANSRVC_URL")
echo "WANSRVC_URL config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o 'sessionKey=[0-9]*' | sed 's/sessionKey=//')

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"
    
    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$WANSRVC_UPDATE_URL&sessionKey=$SESSION_KEY")
    echo "WANSRVC settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi

# Получение страницы настроек pppoe
HTML_TEXT=$(curl -s -b cookies.txt "$PPPOE_URL")
echo "pppoe config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o "sessionKey='[0-9]*'" | sed "s/sessionKey='//; s/'//")

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"
    
    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$PPPOE_UPDATE_URL?enblEnetWan=0&ntwkPrtcl=12&vlanMuxId=1199&vlanMuxPr=0&autoAddtoDefBr=0&serviceName=pppoe_veip0.1199&sessionKey=$SESSION_KEY")
    echo "pppoe settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi

# Получение страницы настроек ifcgateway
HTML_TEXT=$(curl -s -b cookies.txt "$IFCGATEWAY_URL")
echo "ifcgateway config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o 'sessionKey=[0-9]*' | sed 's/sessionKey=//')

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"
    
    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$IFCGATEWAY_UPDATE_URL?pppUserName=name&pppPassword=pass&pppTimeOut=0&pppConnTrigger=1&useStaticIpAddress=0&pppLocalIpAddress=0.0.0.0&pppIpExtension=0&enblFirewall=1&enblNat=1&enblNat=1&enblFirewall=1&enblFullcone=0&pppAuthMethod=0&pppServerName=&pppAuthErrorRetry=0&enblPppDebug=0&pppToBridge=0&enblIgmp=0&noMcastVlanFilter=0&sessionKey=$SESSION_KEY")
    echo "ifcgateway settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi

# Получение страницы настроек ifcdns
HTML_TEXT=$(curl -s -b cookies.txt "$IFCDNS_URL")
echo "IFCDNS config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o 'sessionKey=[0-9]*' | sed 's/sessionKey=//')

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"
    
    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$IFCDNS_UPDATE_URL?defaultGatewayList=ppp0.1&sessionKey=$SESSION_KEY")
    echo "IFCDNS settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi

# Получение страницы настроек ntwksum2
HTML_TEXT=$(curl -s -b cookies.txt "$NTWKSUM2_URL")
echo "NTWKSUM2 config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o 'sessionKey=[0-9]*' | sed 's/sessionKey=//')

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"

    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$NTWKSUM2_UPDATE_URL?dnsIfcsList=ppp0.1&dnsPrimary=0.0.0.0&dnsSecondary=0.0.0.0&dnsRefresh=0&sessionKey=$SESSION_KEY")
    echo "NTWKSUM2 settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi

# Получение страницы настроек wancfg.cmd
HTML_TEXT=$(curl -s -b cookies.txt "$WANCFG_URL")
echo "wancfg config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o "sessionKey=['\"]\?[0-9]*['\"]\?" | head -n 1 | sed -E "s/sessionKey=['\"]?([0-9]+)['\"]?/\\1/")

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"
    echo "Extracted sessionKey: '$SESSION_KEY'"

    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$WANCFG_UPDATE_URL?action=add&sessionKey=$SESSION_KEY")
    echo "wancfg settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi

# Получение страницы настроек wanmap
HTML_TEXT=$(curl -s -b cookies.txt "$WANMAP_URL")
echo "WANMAP config page fetched."

# Извлечение sessionKey
SESSION_KEY=$(echo "$HTML_TEXT" | grep -o "sessionKey = '[0-9]*'" | sed "s/sessionKey = '//; s/'//")

if [ -n "$SESSION_KEY" ]; then
    echo "Session key found: $SESSION_KEY"
    echo "Extracted sessionKey: '$SESSION_KEY'"

    # Отправка запроса с sessionKey
    RESPONSE=$(curl -s -b cookies.txt "$WANMAP_UPDATE_URL?wanGroupCfgList=ppp0.1/1&sessionKey=$SESSION_KEY")
    echo "WANMAP settings update response received."
else
    echo "Failed to find sessionKey. It may be stored in cookies."
    cat cookies.txt
fi



