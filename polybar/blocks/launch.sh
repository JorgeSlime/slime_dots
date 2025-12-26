#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/blocks"
#
## Terminate already running bar instances
killall -q polybar
#
## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#
## Launch the bar
polybar -q main -c "$DIR"/config.ini &


#OTHER CONFIGURATION TO LAUNCH POLYBAR ON MULTIPLE MONITORS
#
## Add this script to your wm startup file.
#
#DIR="$HOME/.config/polybar/blocks"
#
## Terminate already running bar instances
#killall -q polybar
#
## Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#
## Launch one bar per monitor detected
#for m in $(polybar --list-monitors | cut -d":" -f1); do
#    MONITOR=$m polybar -q main -c "$DIR"/config.ini &
#done



#TERCER INTENTO DE CONFIGRACION PARA DOS MONITORES
#!/usr/bin/env bash

#DIR="$HOME/.config/polybar/blocks"
#
## Terminar instancias existentes
#killall -q polybar
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#
## Detectar monitores
#MONITORS=$(polybar --list-monitors | cut -d":" -f1)
#
## Solo lanzar barra en dos monitores (o los que existan)
#for m in $MONITORS; do
#    MONITOR=$m polybar -q main -c "$DIR"/config.ini &
#done





