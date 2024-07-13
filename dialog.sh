#!/bin/bash
while true; do
	usuario=$(dialog --stdout \
        --title "Digite o usuário!" \
        --inputbox "usuario" \
        0 0)
	senha=$(dialog --stdout \
			--title "Digite a senha!" \
			--passwordbox "senha" \
			0 0)
	if [ $? -eq 1 ]; then
		echo 50; sleep 1s; echo 100; sleep 1s | dialog --title "saindo" --gauge "saindo..." 8 40 60; exit 0
	else

		if [ "$usuario" == "admin" ] && [ "$senha" == "admin123" ]; then
			while true; do
				escolha=$(dialog --stdout \
						--title "menu de comandos" \
						--menu "escolha o comando" \
						0 0 0 \
						ifconfig 'interfaces de rede' \
						lsusb 'lista de dispositivos conectados')
				if [ "$?" -eq "1" ]; then
					echo 50; sleep 1s; echo 100; sleep 1s | dialog --title "saindo" --gauge "saindo..." 8 40 60
					exit 0
				else
					case "$escolha" in
						ifconfig)
							dialog --title "output do ifconfig" --msgbox "$(ifconfig)" 0 0
							[ $? -eq 0 ]; continue
							;;
						lsusb)
							dialog --title "output do lsusb" --msgbox "$(lsusb)" 0 0
							[ $? -eq 0 ]; continue
							;;
					esac
				fi
			done
		else
			dialog --title "usuário ou senha incorreta(o), tente novamente!" --msgbox "Senha incorreta, tente novamente!" 0 0
			continue
		fi
	fi
done
