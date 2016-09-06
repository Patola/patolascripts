#!/bin/zsh
zenity --question --title "Coloque o CD no drive" && {
  if [ -d /media/*/20*/DVD_RTAV ]; then
    mkdir /tmp/kim.$$ && cd /tmp/kim.$$ || { zenity --error --title 'Diretório falho' --text='Não consegui criar diretório temporário'; exit 1 }
    notify-send -t 30000 'Aguarde' 'Copiando disco... Demora um pouco'
    if /dados/dvd-vr-master/dvd-vr /media/*/20*/DVD_RTAV/*.IFO /media/*/20*/DVD_RTAV/*.VRO 2>&1 | tee /tmp/copia.$$.log; then
      notify-send -t 30000 'Aguarde' 'Convertendo vídeos... Demora outro pouco!'
      OUTDIR="${USER}-$(date '+%Y-%m-%d-%H-%M')"; mkdir ~/${OUTDIR} && cd ~/${OUTDIR} || { zenity --error --title 'Diretório falho' --text='Não consegui criar diretório de saída dos filmes'; exit 4 }
      for vob in /tmp/kim.$$/*.vob; do
        INPUT="$vob"
        OUTPUT=$(basename "$vob")
        OUTPUT=~/${OUTDIR}/"${OUTPUT%.*}".mp4
        avconv -i "$INPUT" -c:a copy -c:v copy -y "$OUTPUT" -r 29.97
      done || { zenity --error --title 'Não consegui converter' --text='Houve algum erro ao tentar converter os vídeos.'; exit 5 }
      zenity --info --title 'Operação concluída com sucesso!' --text="Arquivos convertidos, verifique diretório ~/${OUTDIR}"; nohup nautilus ~/"${OUTDIR}" > /dev/null 2>&1 &
    else
      zenity --error --title 'Cópia do disco falhou' --text='Veja o arquivo /tmp/copia.'$$'.log para ver a razão.'
      exit 3
    fi

  else
    zenity --error --title 'Não achei!' --text='Não consegui detectar minidisco da câmera Sony no drive'; exit 2
  fi
}
notify-send -t 5000 'Tchau!' 'Até a próxima!'
rm -rf /tmp/kim.$$
