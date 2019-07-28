#!/bin/bash
  case $1 in    
    init)
        echo ' start init..... '
        common/build_init.sh
        ;;
    make)          
        echo ' start make...   ' 
        common/build_make.sh
        ;;
    *)
        echo './build./sh init|make'
  esac
