#!/bin/sh
sed -i \
         -e 's/#0e1929/rgb(0%,0%,0%)/g' \
         -e 's/#e9ecf1/rgb(100%,100%,100%)/g' \
    -e 's/#0e1929/rgb(50%,0%,0%)/g' \
     -e 's/#c74539/rgb(0%,50%,0%)/g' \
     -e 's/#0e1929/rgb(50%,0%,50%)/g' \
     -e 's/#c78437/rgb(0%,0%,50%)/g' \
	"$@"