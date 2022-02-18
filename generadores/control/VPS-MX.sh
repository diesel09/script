#!/bin/bash
clear
cd $HOME
SCPdir="/etc/newadm"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPinst="/etc/ger-inst"
fecha=`date`;
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
service apache2 restart > /dev/null 2>&1
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
mkdir -p /etc/B-ADMuser &>/dev/null
#rm -rf /etc/localtime &>/dev/null
#ln -s /usr/share/zoneinfo/America/Argentina/Tucuman /etc/localtime &>/dev/null
#ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime &>/dev/null
rm $(pwd)/$0 &> /dev/null
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
  -bar3)cor="\e[0;35m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m" && echo -e "${cor}${SEMCOR}";;
  -bar4)cor="\e[1;35m——————————————————————————————————————————————————————" && echo -e "${cor}${SEMCOR}";;
 esac
}

#------- BARRA DE ESPERA

fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne "  \033[1;33m["
   for((i=0; i<40; i++)); do
   echo -ne "\033[1;31m>"
   sleep 0.1
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1 && tput dl1
done
echo -ne "  \033[1;33m[\033[1;31m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\033[1;33m] - \033[1;32m OK \033[0m\n"
sleep 1s
}
msg -bar2
echo -e " \e[97m\033[1;41m   =====>>►► SCRIPT - ADMIN VPS ◄◄<<=====     \033[1;37m"
msg -bar2
msg -ama "               PREPARANDO INSTALACION"
msg -bar2
##PAKETES
echo ""
echo -e "\033[97m    ◽️ INTENTANDO DETENER UPDATER SECUNDARIO " 
fun_bar " killall apt apt-get > /dev/null 2>&1 "
echo -e "\033[97m    ◽️ INTENTANDO RECONFIGURAR UPDATER "
fun_bar " dpkg --configure -a > /dev/null 2>&1 "
echo -e "\033[97m    ◽️ INSTALANDO S-P-C "
fun_bar " apt-get install software-properties-common -y > /dev/null 2>&1"
echo -e "\033[97m    ◽️ INSTALANDO LIBRERIA UNIVERSAL "
fun_bar " sudo apt-add-repository universe -y > /dev/null 2>&1"
echo -e "\033[97m    ◽️ INSTALANDO PYTHON "
fun_bar " sudo apt-get install python -y > /dev/null 2>&1"
apt-get install python -y &>/dev/null
echo -e "\033[97m    ◽️ INSTALANDO NET-TOOLS "
fun_bar "apt-get install net-tools -y > /dev/null 2>&1"
apt-get install net-tools -y &>/dev/null
apt-get install curl -y > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
echo -e "\033[97m    ◽️ DESACTIVANDO PASS ALFANUMERICO "
sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password > /dev/null 2>&1 
fun_bar "service ssh restart > /dev/null 2>&1 "
msg -bar2
#echo -e "${cor[2]} VERIFICAR POSIBLE ACTUALIZACION DE S.O (Default n)"
#echo -e "\033[1;34m     (Este proceso puede demorar mucho Tiempo)"
#msg -bar2
#read -p "   [ s | n ]: " -e -i n updater   
[[ "$updater" = "s" || "$updater" = "S" ]] && updater
#msg -bar2
#echo -e "\033[93m              AGREGAR/EDITAR PASS ROOT\033[97m" 
#msg -bar
#echo -e "\033[1;96m DIGITE NUEVA CONTRASEÑA:\033[0;37m"; read -p " " pass
#(echo $pass; echo $pass)|passwd root 2>/dev/null
sleep 1s
#msg -bar
#echo -e "\033[97m      CONTRASEÑA AGREGADA O EDITADA CORECTAMENTE"
#echo -e "\033[97m SU CONTRASEÑA AHORA ES: \e[41m $pass \033[0;37m"
#msg -bar
clear
### PAQUETES PRINCIPALES 
msg -bar
echo -e "\033[92m -- FINALIZANDO INSTALACION DE PAQUETES NECESARIOS -- "
msg -bar
apt-get install grep -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "grep"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "grep"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install grep............ $ESTATUS "
apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install gawk............ $ESTATUS "
apt-get install mlocate -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install mlocate......... $ESTATUS "
#lolcat gem
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install lolcat.......... $ESTATUS "
#at
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] || apt-get install at -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install at.............. $ESTATUS "
#nano
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install nano............ $ESTATUS "
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install bc.............. $ESTATUS "
#lsof
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || apt-get install lsof -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install lsof............ $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install figlet.......... $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install cowsay.......... $ESTATUS "
#screen
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install screen.......... $ESTATUS "
#python
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install python.......... $ESTATUS "
#python3
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install python3......... $ESTATUS "
#python3-pip
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install python3-pip..... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install curl............ $ESTATUS "
#ufw
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install ufw............. $ESTATUS "
#unzip
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install unzip........... $ESTATUS "
#zip
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install zip............. $ESTATUS "
#apache2
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install apache2......... $ESTATUS "
sleep 3s
clear
### FIXEADOR PARA SISTEMAS 86_64
idfix64_86 () {
msg -bar2
echo -e "ENCASO DE PEDIR ALGUNA INSTALACION ESCOJA: y "
apt-get update; apt-get upgrade 
apt-get install curl
apt-get install lsof
apt-get install sudo
apt-get install figlet
apt-get install cowsay
apt-get install bc
apt-get install python
apt-get install at 
service apache2 restart
clear
msg -bar2
echo -e "ESCOJER PRIMERO #All locales# Y LUEGO #en_US.UTF-8# " 
clear
export LANGUAGE=en_US.UTF-8\
  && export LANG=en_US.UTF-8\
  && export LC_ALL=en_US.UTF-8\
  && export LC_CTYPE="en_US.UTF-8"\
  && locale-gen en_US.UTF-8\
  && sudo apt-get -y install language-pack-en-base\
  && sudo dpkg-reconfigure locales
clear
}
msg -bar2
echo -e "\033[1;97m     ¿APLICAR PARCHES PARA CORREGIR ERRORES?" 
msg -bar2
echo -e "\033[1;32m 1- Escoja:(N) Para Instalacion Normal"
echo -e "\033[1;31m 2- Escoja:(S) Si ya intento instalar el script y\n precento errores, aplique este parche."
msg -bar2
echo -e "\033[1;39m Al preciona N continuara la instalacion Normalmente"
msg -bar2
read -p " [ S | N ]: " idfix64_86   
[[ "$idfix64_86" = "s" || "$idfix64_86" = "S" ]] && idfix64_86
clear
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}  
fun_ipe () { 
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1) 
MIP2=$(wget -qO- ifconfig.me) 
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP" 
} 
fun_ip2 () { 
MIP2=$(wget -qO- ifconfig.me) 
MIP=$(wget -qO- whatismyip.akamai.com) 
if [ $? -eq 0 ]; then 
IP="$MIP" 
else 
IP="$MIP2" 
fi 
} 

function_verify () {
  permited=$(curl -sSL "https://raw.githubusercontent.com/diesel09/AdminVPS2/main/Control-Bot")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  echo -e "\n\n\n\033[1;95m======================================================\n ¡ESTA KEY NO CONCUERDA CON EL INSTALADOR!,CONTACTE A @FelipeCouoh ;)\n======================================================\n"
  [[ -d /etc/newadm ]] && rm -rf /etc/newadm
  exit 1
  } || {
  ### INTALAR VERCION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/diesel09/AdminVPS2/main/version")
  echo "$v1" > /etc/versin_script
  }
}
#vp (){
#echo "
#
 # █░░▒█ █▀▀█ █▀▀▀█ ░░ █▀▄▀█ ▀▄▒▄▀
 #▒█▒█░ █▄▄█ ▀▀▀▄▄ ▀▀ █▒█▒█ ░▒█░░
 #░▀▄▀░ █░░░ █▄▄▄█ ░░ █░░▒█ ▄▀▒▀▄

#"
#}
funcao_idioma () {
msg -bar2
#vp
figlet " ADMIN VPS " | lolcat
echo -e "     Adquiera su serial y apoye al desarrollador"
msg -bar2
pv="$(echo es)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
}
install_fim () {
msg -ama "               Finalizando Instalacion" && msg bar2
[[ $(find /etc/newadm/ger-user -name nombre.log|grep -w "nombre.log"|head -1) ]] || wget -O /etc/newadm/ger-user/nombre.log https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/nombre.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name IDT.log|grep -w "IDT.log"|head -1) ]] || wget -O /etc/newadm/ger-user/IDT.log https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/IDT.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name tiemlim.log|grep -w "tiemlim.log"|head -1) ]] || wget -O /etc/newadm/ger-user/tiemlim.log https://raw.githubusercontent.com/diesel09/AdminVPS2/main/tiemlim.log &>/dev/null

wget -O /bin/rebootnb https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/ArchivosUtilitarios/rebootnb &> /dev/null
chmod +x /bin/rebootnb 
wget -O /bin/resetsshdrop https://raw.githubusercontent.com/diesel09/AdminVPS2/main/resetsshdrop &> /dev/null
chmod +x /bin/resetsshdrop
wget -O /etc/versin_script_new https://raw.githubusercontent.com/diesel09/AdminVPS2/main/versionN &>/dev/null
msg -bar2
echo -e "	\e[1;44mCAMBIAR  RESELLER\e[0m"
msg -bar
echo ""
read -p "Escriba su nuevo Reseller: " creditresell
echo "$creditresell" > /etc/newadm/message.txt
msg -bar
echo "NUEVO RESELLER AGREGADO CON EXITO"
msg -bar
echo '#!/bin/sh -e' > /etc/rc.local
sudo chmod +x /etc/rc.local
echo "sudo rebootnb" >> /etc/rc.local
echo "sudo resetsshdrop" >> /etc/rc.local
echo "sleep 2s" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
/bin/cp /etc/skel/.bashrc ~/
echo 'clear' >> .bashrc
echo 'DATE=$(date +"%d-%m-%y")' >> .bashrc
echo 'TIME=$(date +"%T")' >> .bashrc
echo 'echo ""' >> .bashrc
#vp >> .bashrc
echo 'echo -e "\033[91m     _    ____  __  __ ___ _   _  __     ______  ____  " '>> .bashrc
echo 'echo -e "\033[91m    / \  |  _ \|  \/  |_ _| \ | | \ \   / /  _ \/ ___|  " '>> .bashrc
echo 'echo -e "\033[91m   / _ \ | | | | |\/| || ||  \| |  \ \ / /| |_) \___ \  " '>> .bashrc
echo 'echo -e "\033[91m  / ___ \| |_| | |  | || || |\  |   \ V / |  __/ ___) |  " '>> .bashrc
echo 'echo -e "\033[91m /_/   \_\____/|_|  |_|___|_| \_|    \_/  |_|   |____/  " '>> .bashrc
echo 'echo "" '>> .bashrc
echo 'mess1="$(less /etc/newadm/message.txt)" ' >> .bashrc
echo 'echo "" '>> .bashrc
echo 'echo -e "\033[92m        RESELLER : $mess1 "'>> .bashrc
echo 'echo "" '>> .bashrc                                               
echo 'echo -e "\033[97m   PARA MOSTAR PANEL BASH ESCRIBA:  sudo menu "'>> .bashrc
#echo 'wget -O /etc/versin_script_new https://raw.githubusercontent.com/VPS-MX/VPS-MX-8.0/master/Vercion &>/dev/null'>> .bashrc
echo 'echo ""'>> .bashrc
echo 'echo -e "	\e[44;1;37mNombre del Servidor\e[0m : \e[1;33m $HOSTNAME \e[0m"' >> .bashrc
echo 'echo -e "	\e[44;1;37mFecha del Servidor\e[0m : \e[1;33m $DATE \e[0m"' >> .bashrc
echo 'echo -e "	\e[44;1;37mHora del Servidor\e[0m : \e[1;33m $TIME \e[0m"' >> .bashrc
echo 'echo ""'>> .bashrc
echo -e "         COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
echo -e "\033[1;41m                     menu                        \033[0;37m" && msg -bar2
sleep 5
}
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
verificar_arq () {
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
[[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
case $1 in
"menu"|"message.txt")ARQ="${SCPdir}/";; #Menu
"usercodes")ARQ="${SCPusr}/";; #Panel SSRR
"C-SSR.sh")ARQ="${SCPinst}/";; #Instalacao
"openssh.sh")ARQ="${SCPinst}/";; #Instalacao
"squid.sh")ARQ="${SCPinst}/";; #Instalacao
"dropbear.sh")ARQ="${SCPinst}/";; #Instalacao
"openvpn.sh")ARQ="${SCPinst}/";; #Instalacao
"ssl.sh")ARQ="${SCPinst}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-libev.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-R.sh")ARQ="${SCPinst}/";; #Instalacao 
"v2ray.sh")ARQ="${SCPinst}/";; #Instalacao
"v2ui.sh")ARQ="${SCPinst}/";; #Instalacao
"budp.sh")ARQ="${SCPinst}/";; #Instalacao
"trojanserver.sh")ARQ="${SCPinst}/";; #Instalacao
"payssl.sh")ARQ="${SCPinst}/";; #Instalacao
"sdns.sh")ARQ="${SCPinst}/";; #Instalacao
"sw.sh")ARQ="${SCPinst}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPinst}/";; #Instalacao
*)ARQ="${SCPfrm}/";; #Ferramentas
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

NOTIFY () {
msg -bar
msg -ama " Notify-BOT (Notificasion Remota)| VPS-MX By @Kalix1 "
msg -bar
echo -e "\033[1;94m Es una opcion para notificar cuando\n un usuario sea bloquedo o este expirado, e info de VPS."
echo -e "\033[1;97m Deve usar el BOT de Telegram @Noti_VPSMX_Bot"
echo -e "\033[1;92m Para sacar su ID solo Meta el comando /MENU en el BOT @USA1_BOT"
echo -e "\033[1;92m Aparesera un pequeño menu donde aparesera su  👤 ID"
msg -bar
echo -e "\033[1;97mIgrese un nombre para el VPS:\033[0;37m"; read -p " " nombr
echo "${nombr}" > /etc/newadm/ger-user/nombre.log
echo -e "\033[1;97mIgrese su ID 👤:\033[0;37m"; read -p " " idbot
echo "${idbot}" > /etc/newadm/ger-user/IDT.log 
msg -bar
echo -e "\033[1;32m         ID AGREGADO CON EXITO"
msg -bar
NOM="$(less /etc/newadm/ger-user/nombre.log)"
NOM1="$(echo $NOM)"
IDB1=`less /etc/newadm/ger-user/IDT.log` > /dev/null 2>&1
IDB2=`echo $IDB1` > /dev/null 2>&1

KEY="862633455:AAGJ9BBJanzV6yYwLSemNAZAVwn7EyjrtcY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MSG="⚠️ AVISO DE VPS: $NOM1 ⚠️
👉 MENSAJE DE PRUEBA
🔰 EXITOSO... SALUDOS"
curl -s --max-time 10 -d "chat_id=$IDB2&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null

echo -e "\033[1;34mSE ENVIO MENSAJE DE PRUEBA SI NO LLEGA CONTACTE A @Kalix1 "
}
fun_ip
wget -O /usr/bin/trans https://raw.githubusercontent.com/diesel09/AdminVPS2/main/trans &> /dev/null
wget -O /bin/Desbloqueo.sh https://raw.githubusercontent.com/diesel09/AdminVPS2/main/Desbloqueo.sh &> /dev/null
chmod +x /bin/Desbloqueo.sh
wget -O /bin/monitor.sh https://raw.githubusercontent.com/diesel09/AdminVPS2/main/monitor.sh &> /dev/null
chmod +x /bin/monitor.sh
wget -O /var/www/html/estilos.css https://raw.githubusercontent.com/diesel09/script/master/Install/estilos.css &> /dev/null
msg -bar2
msg -ama "     [ SCRIPT - ADMIN VPS \033[1;97m VERSION ACTUALIZADA\033[1;33m ]"
msg -ama "  \033[1;96m      🔰Usar Ubuntu 18 a 64 De Preferencia🔰 "
msg -bar2
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }
error_fun () {
msg -bar2 && msg -verm "PORT 81 BLOQUEADO VERIFIQUE FIREWALL" && msg -bar2
[[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
exit 1
}
invalid_key () {
msg -bar2 && msg -verm "¡Key Invalida, Usada o Expirada! " && msg -bar2
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
exit 1
}
while [[ ! $Key ]]; do
msg -bar2 && msg -ne "DIGITE LA KEY: " && read Key
tput cuu1 && tput dl1
done
msg -ne "# Verificando Key # : "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[1;32m Key Completa" || {
   echo -e "\033[1;91m Key Incompleta"
   invalid_key
   exit
   }
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
sleep 1s
function_verify
updatedb
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
   msg -bar2
   msg -verd "$(source trans -b es:${id} " GRACIAS POR ADQUIRIR TU SERIAL"|sed -e 's/[^a-z -]//ig'): \033[1;31m[ADMIN VPS]"
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   pontos="."
   stopping="$(source trans -b es:${id} "Verificando Actualizaciones"|sed -e 's/[^a-z -]//ig')"
   for arqx in $(cat $HOME/lista-arq); do
   msg -verm "${stopping}${pontos}"
   wget -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" || error_fun
   tput cuu1 && tput dl1
   pontos+="."
   done
   sleep 1s
   msg -bar2
   listaarqs="$(locate "lista-arq"|head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs   
   cat /etc/bash.bashrc|grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' > /etc/bash.bashrc.2
   echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >> /etc/bash.bashrc.2
   mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
   echo "${SCPdir}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
   echo "${SCPdir}/menu" > /usr/bin/adm && chmod +x /usr/bin/adm
   echo "$Key" > ${SCPdir}/key.txt
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "es" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
   #echo -e "${cor[2]}         DESEAS INSTALAR NOTI-BOT?(Default n)"
   #echo -e "\033[1;34m  (Deves tener Telegram y el BOT: @Noti_VPSMX_Bot)"
   #msg -bar2
   #read -p " [ s | n ]: " NOTIFY   
   #[[ "$NOTIFY" = "s" || "$NOTIFY" = "S" ]] && NOTIFY
   #msg -bar2
   [[ ${byinst} = "true" ]] && install_fim
else
invalid_key
fi
rm -rf instalscript.sh
