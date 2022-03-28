#!/bin/bash
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2RpZXNlbDA5L0FkbWluVlBTMi9tYXN0ZXIvZ2VyYWRvcg=="
SUB_DOM='base64 -d'
rm $(pwd)/$0
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${VERMELHO}======================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}
clear
cd $HOME
tput cuu1 && tput dl1
msg -bar
msg -ama "HOLA! \033[1;32m[ EJECUTANDO ]  \033[1;33m[\033[1;34m VPS-MX \033[1;33m] \033[1;31m[\033[1;37m 8.4G\033[1;31m]"
echo " "
msg -verm "Esta opción necesita autorizacion de IP "
msg -verm "Contacte al administrador @FelipeCouoh "
msg -verm "Una vez Autorizado puede instalar las veces que desee"
msg -verm "Este panel es independiente contiene sus propias funciones"
msg -bar
while [[ $Key != @(s|S|y|Y|n|N) ]]; do
msg -ne "Continuar [S/N]: " && read Key
tput cuu1 && tput dl1
done
if [[ $Key = @(s|S|y|Y) ]]; then

lor1='\033[1;31m';lor2='\033[1;32m';lor3='\033[1;33m';lor4='\033[1;34m';lor5='\033[1;35m';lor6='\033[1;36m';lor7='\033[1;37m'
IP=$(wget -qO- whatismyip.akamai.com)
[[ "$IP" = "" ]]&& IP="errorp"
PASS=$(wget -qO- https://raw.githubusercontent.com/diesel09/AdminVPS2/main/Control-IP |grep "$IP" |awk -F : {'print $1'})
rm -rf instgerador.sh
if [ "$IP" = "$PASS" ]; then
clear
else
echo -e "${lor4}****************************************${lor7}"
echo -e
echo -e "\033[97m   ◆ ACCESO NO AUTORIZADO CONTACTAME PARA ACCESOS"
echo -e "\033[97m   ◆ TELEGRAM: @FelipeCouoh"
echo -e "\033[97m   ◆ WHATSAPP: +52 9842147259"
echo -e
echo -e "${lor4}****************************************${lor7}"
for pid in $(pgrep python);do
kill $pid
done
exit
exit 0
fi
if [ $(id -u) -eq 0 ];then
clear
else
echo -e "Run the script as user${lor2}root${lor7}"
exit
fi 
sleep 2s
echo -e " \033[1;32m IP AUTORIZADA! "
sleep 1s
echo -e " \033[1;32mPerfecto, Iniciando instalacion..."
#msg -verm "Perfecto, Iniciando Panel: "
echo " "
sleep 1s
echo -e " \033[1;32m[ Adquiera este Script en: ] "
sleep 1s
echo -e " \033[1;32m[ Telegram: @KeyVpspremium_bot ] "
sleep 2s
#wget -O $HOME/VPS-MX wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MX-FREE/main/VPS-MX &> /dev/null
#chmod +x $HOME/VPS-MX*
#local LINGUAGE=$(cat ${SCPidioma})
#$HOME/VPS-MX "${LINGUAGE}"
#wget https://raw.githubusercontent.com/diesel09/gcapital/main/VPS-MX; chmod 777 VPS-MX; ./VPS-MX
#clear
#rm -rf VPS-MX
msg -bar
else
msg -verm "Procedimiento Cancelado: "
msg -bar
fi
exit
ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="*";;
"*")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="%";;
"%")txt[$i]="4";;
"-")txt[$i]="K";;
"K")txt[$i]="-";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"gerar.sh")ARQ="/usr/bin/";;
"http-server.py")ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
function_verify () {
  permited=$(curl -sSL "https://raw.githubusercontent.com/diesel09/AdminVPS2/main/Control-IP")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  echo -e "\n\n\n\033[1;31m====================================================="
  echo -e "\033[1;31m       ¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADA!"
  echo -e "\033[1;31m                CONTACTE A @FelipeCouoh"
  echo -e "\033[1;31m=====================================================\n\n\n"
  [[ -d /etc/SCRIPT ]] && rm -rf /etc/SCRIPT
  exit 1
  } || {
  ### INTALAR VERCION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/diesel09/AdminVPS2/main/versionN")
  echo "$v1" > /etc/versin_script
  }
}
function_verify
echo -e "\033[1;33mInstalando Archivos... "
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}/GERADOR > /dev/null 2>&1
sleep 1s
[[ -e $HOME/lista-arq ]] && {
for arqx in `cat $HOME/lista-arq`; do
echo -ne "\033[1;33mDescargando Archivo \033[1;31m[$arqx] "
wget -O $HOME/$arqx ${REQUEST}/${arqx} > /dev/null 2>&1 && {
echo -e "\033[1;31m- \033[1;32mDescargado con exito!"
[[ -e $HOME/$arqx ]] && veryfy_fun $arqx
} || echo -e "\033[1;31m- \033[1;31mFalha (nao recebido!)"
done
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://raw.githubusercontent.com/diesel09/AdminVPS2/main/trans &> /dev/null
[[ -e /bin/http-server.py ]] && mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
cp /bin/http-server.sh /etc/SCRIPT
mv /etc/SCRIPT/http-server.sh /etc/SCRIPT/http-server.py
cp /usr/bin/gerar.sh /etc/SCRIPT
cd /etc/SCRIPT
rm -rf FERRAMENTA KEY KEY! INVALIDA!
rm $HOME/lista-arq
sed -i -e 's/\r$//' /usr/bin/gerar.sh
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo "/usr/bin/gerar.sh" > /usr/bin/gerar && chmod +x /usr/bin/gerar
echo -e "\033[1;33m Use el Comando \033[1;31mgerar.sh o gerar \033[1;33mpara generar las Keys"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey Invalida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}

echo -ne "\033[0m"
echo "qra-atsilK?29@%6087%?66d5K8888:%05+08+@@?+91" > /etc/key-gerador
apt-get install netcat -y &>/dev/null
