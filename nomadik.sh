#!/bin/bash
ascii_logo() {
  echo -e "\e[1;32m"
  cat assets/ascii_logo.txt
  echo -e "\e[0m"
}
show_help() {
  echo "Usage: ./nomadik.sh [--matrix] [--help]"
  echo "  --matrix   Launch Matrix rain animation"
  echo "  --help     Show this help message"
}
case "$1" in
  --matrix)
    ascii_logo
    sleep 1
    bash scripts/matrix.sh
    ;;
  --help)
    show_help
    ;;
  *)
    ascii_logo
    echo "Toolkit initializing..."
    ;;
esac
