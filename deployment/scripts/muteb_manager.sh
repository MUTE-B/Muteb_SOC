#!/bin/bash


case "$1" in


start)

echo "Starting MUTEB Enterprise Platform"

;;


stop)

echo "Stopping MUTEB Enterprise Platform"

;;


status)

echo "MUTEB Enterprise Status: ONLINE"

;;


restart)

echo "Restarting MUTEB Enterprise Platform"

;;


*)

echo "Usage: ./muteb_manager.sh {start|stop|status|restart}"

;;


esac

