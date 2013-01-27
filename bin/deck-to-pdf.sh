#!/bin/sh


# convert a deck.js slideshow to pdf using phantomjs, image-magick & pdftk
# the idea is to have pdfs that you can use for your presentation as a last resort 
# currently some features are missing, e.g. phantomjs doesn't seem to raster the text-shadows
# but images &c should be fine
#
# uses phantom1_2-deckjs-to-png.js, a phantomjs script to convert deck.js to png

echo `pwd`

if [ "" = "$1" ]; then
    echo "Usage: ./phantom-pdf.sh <slides filename> <PDF filename>"
    exit 1
fi
if [ "" = "$2" ]; then
    echo "Usage: ./phantom-pdf.sh <slides filename> <PDF filename>"
    exit 1
fi

#store pngs &c here
mkdir -p tmp-pdf/
rm -f tmp-pdf/*.png
rm -f tmp-pdf/*.pdf
rm -f tmp-pdf/*.html

#nb assumes phantom1_2-deckjs-to-png.js is in the same dir as this script!
./phantomjs1_8 phantom1_8-deckjs-to-png.js $1 tmp-pdf/

echo 'converting png to pdf'
for f in tmp-pdf/*.png
do
    convert $f $f.pdf
done

echo 'concatenating pdf pages'
pdftk tmp-pdf/*.pdf cat output $2

rm -r tmp-pdf/
