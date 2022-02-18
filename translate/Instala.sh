#!/bin/bash
#sudo apt-get update  &>/dev/null
#sudo apt-get wget -y &>/dev/null
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime &>/dev/null
#ln -s /usr/share/zoneinfo/America/Argentina/Tucuman /etc/localtime &>/dev/null
rm $(pwd)/$0 &> /dev/null
### CONFIGURAR POR 22 SSH
#grep -v "^Port 22" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config &>/dev/null
#echo "Port 22" >> /etc/ssh/sshd_config
### COLORES Y BARRA 
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
 msg -bar2
 msg -ama "        [ ADMIN VPS - SCRIPT \033[1;97m  Bienvenido \033[1;33m ]"
 echo -e  "\033[1;97m               EJECUTANDO ACTUALIZADOR  \033[1;34m "
 msg -bar2
## Script name
SCRIPT_NAME=vpsmxup
## Install directory
WORKING_DIR_ORIGINAL="$(pwd)"
INSTALL_DIR_PARENT="/usr/local/vpsmxup/"
INSTALL_DIR=${INSTALL_DIR_PARENT}${SCRIPT_NAME}/
## /etc/ config directory
mkdir -p "/etc/vpsmxup/"
## Install/update
if [ ! -d "$INSTALL_DIR" ]; then
	echo -e  "\033[1;97m           Instalando Paquetes Prioritarios"
	echo "           --------------------------------"
	sleep 2
	mkdir -p "$INSTALL_DIR_PARENT"
	cd "$INSTALL_DIR_PARENT"
    wget https://raw.githubusercontent.com/diesel09/gcapital/main/Install/zzupdate-master/zzupdate.default.conf -O /usr/local/vpsmxup/vpsmxup.default.conf  &> /dev/null
	#chmod +x /usr/local/vpsmxup/vpsmxup.default.conf 
	rm -rf /usr/local/vpsmxup/vpsmxup.sh
    wget https://raw.githubusercontent.com/diesel09/script/master/generadores/control/zzupdate.sh -O /usr/local/vpsmxup/vpsmxup.sh &> /dev/null
	chmod +x /usr/local/vpsmxup/vpsmxup.sh
	rm -rf /usr/bin/vpsmxup
    wget https://raw.githubusercontent.com/diesel09/script/master/generadores/control/zzupdate.sh -O /usr/bin/vpsmxup &> /dev/null
	chmod +x /usr/bin/vpsmxup
	echo -e  "\033[1;97m              Copiando Instalador Interno "
	
	echo "           --------------------------------"	
	
	msg -bar2
	sleep 2
else
	echo ""
fi

ubu16_fun () {
    wget -O /etc/apt/sources.list https://raw.githubusercontent.com/diesel09/VPS-MX-8.0/master/Repositorios/16.04/sources.list &> /dev/null
	echo -e "\033[1;97m SELECCIONO UBU 16"
}

ubu18_fun () {
    wget -O /etc/apt/sources.list https://raw.githubusercontent.com/diesel09/VPS-MX-8.0/master/Repositorios/18.04/sources.list &> /dev/null
	echo -e "\033[1;97m SELECCIONO UBUNTU 18"
}	

ubu20_fun () {
    wget -O /etc/apt/sources.list https://raw.githubusercontent.com/diesel09/VPS-MX-8.0/master/Repositorios/20.04/sources.list &> /dev/null
	echo -e "\033[1;97m SELECCIONO UBUNTU 20"
}	

otro_fun () {

	source <(curl -sL https://raw.githubusercontent.com/diesel09/v2raynew/main/v2ray.sh)

#echo "OK OTRO"

}
vpsmx8.4g () {
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
rm -rf instalador.sh
if [ "$IP" = "$PASS" ]; then
clear
else
echo -e "${lor4}***********************************${lor7}"
echo -e
echo -e "\033[97m    ◆ ACCESO NO AUTORIZADO CONTACTAME PARA ACCESOS"
echo -e "\033[97m    ◆ TELEGRAM: @FelipeCouoh"
echo -e "\033[97m    ◆ WHATSAPP: +52 982147259"
echo -e
echo -e "${lor4}***********************************${lor7}"
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

wget https://raw.githubusercontent.com/diesel09/gcapital/main/VPS-MX; chmod 777 VPS-MX; ./VPS-MX
clear
rm -rf VPS-MX
msg -bar
else
msg -verm "Procedimiento Cancelado: "
msg -bar
fi
}
	echo -e "\033[1;97m           ---- QUE UBUNTU ESTA USANDO ----"
	echo -e "\033[1;97m  Digite solo el numero segun su respuesta: "
    msg -bar
    echo -e "\033[1;97m Escoja la opcion deseada."
    msg -bar
    echo " 1).- Ubuntu 16.04 "
    echo " 2).- Ubuntu 18.04 "
    echo " 3).- Ubuntu 20.04 "
    echo " 4).- Instalar V2RAY - Instalación Temporal "
    echo -e "\033[1;32m 5).- Instalar VPS-MX 8.4g V. OFICIAL "
    echo " (Esta opción necesita Autorización de su IP "
	msg -bar
	echo -n "Digite solo el numero segun su respuesta: "
    read opcao
    case $opcao in
    1)
    ubu16_fun 
    ;;
    2)
    ubu18_fun
    ;;
    3)
    ubu20_fun
    ;;
    4)
    otro_fun
    ;;
    5)
    vpsmx8.4g
    ;;
    esac

sleep 3
## Restore working directory
cd $WORKING_DIR_ORIGINAL
vpsmxup
