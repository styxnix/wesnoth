#!/bin/bash
V=1
SRC="."
DEST="/tmp"

#The last path we saw -- make it garbage, but not blank.  (Or it will break the '[' test command
LPATH="/////"
#Let us find the files we want
find $SRC -iname "*.mo" -print0 | while read -d $'\0' i
  do
  echo "We found the file name... $i";

  #Now, we rip off the off just the file name.
  FNAME=$(basename "$i" .mo)
  echo "And the basename is $FNAME";
  #Now we get the last chunk of the directory
  ZPATH=$(dirname "$i"  | awk -F'/' '{ print $NF}' )
  echo "And the last chunk of the path is... $ZPATH"

  # If we are down a new path, then reset our counter.
  if [ $LPATH == $ZPATH ]; then
    V=1
  fi;
  LPATH=$ZPATH

  # Eat the error message
  mkdir $DEST/$ZPATH 2> /dev/null
  echo cp \"$i\" \"$DEST/${ZPATH}/${FNAME}${V}\"
  cp "$i" "$DEST/${ZPATH}/${FNAME}${V}"
done
