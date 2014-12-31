#!/bin/zsh

/usr/bin/curl 'http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=EC954473961US' > ~/n900/correios-x.html 2>/dev/null

/usr/bin/diff ~/n900/correios-x.html ~/n900/correios.html > /dev/null 2>&1 || {
	/usr/bin/notify-send -u critical -t 300000 'A página dos correios mudou!!!'
	/usr/bin/mail -s 'A página dos correios mudou!!!' patola@localhost <<EOF > /dev/null 2>&1
Verifque em http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=EC954473961US
EOF
	/usr/bin/mpg321 '/dados/toques-celular/Invasion_Of_The_Gabber_Robots.mp3' > /dev/null 2>&1
}
