#!/bin/sh

rm -rf LangNew
mkdir -p LangNew

for file in Lang/*.pm
do
  charset="ISO-8859-1"
  case "$file" in
      "Lang/russian.pm" ) 
        charset="koi8-r" ;;
      "Lang/swedish.pm" ) 
        charset="ISO-8859-15" ;;
      "Lang/polish.pm" ) 
        charset="ISO-8859-2" ;;
  esac
  newfile=`echo "$file" | sed s/Lang/LangNew/g`
  echo "$file $charset $newfile"
  cat "$file" | \
  perl -e 'while (<>){s/\\x([a-fA-F0-9]{2})/chr(hex $1)/eg; print}' | \
  iconv -f "$charset" -t UTF-8 | \
  perl -e 'while (<>){s/([\x00-\x09\x11-\x1F\x7F-\xFF])/sprintf("\\x%02X", ord $1)/eg; print}' | \
  cat > $newfile


done
