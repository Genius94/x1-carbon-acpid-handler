#!/bin/bash

case "$1" in
    ac_adapter)
        case "$2" in
    	    ACPI0003:00)
                case "$4" in
                    00000000)
                	# unplugged
                        ;;
                    00000001)
                    	# plugged
			echo "14 off" > /proc/acpi/ibm/led
                        ;;
                esac
                ;;
            *)
                logger "ACPI ac_adapter action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
    	    PNP0C0A:00)
		capacity=`cat /sys/class/power_supply/BAT0/capacity`
		if [ $capacity -lt 10 ]; then
		    echo "14 blink" > /proc/acpi/ibm/led
		else
		    echo "14 off" > /proc/acpi/ibm/led
		fi
		logger "battery event triggered at ${capacity}%"
		;;
            *)  logger "ACPI battery action undefined: $2" ;;
        esac
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
