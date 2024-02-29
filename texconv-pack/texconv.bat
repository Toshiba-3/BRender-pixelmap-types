:: A list of examples of command lines using texconv
:: ! the order of the arguments can make a difference !
:: TEXCONV TEXTUREN\AGIP.PIX -P F1MPRO.PAL -o AGIP.TGA -> sets the palette to save to targa
:: texconv %1.gif -O image -o %1.pix
:: texconv %1.pix -P iwarstd.pix -O targa -o %1.tga
:: texconv test.tga -I tga -O image -c BR_PMT_RGB_555 -o test555.pix

:: example of working base/range. Includes the pink transparent id#0 and goes up to id#255 included.
:: texconv-win ref_pal256.tga -n index_8.pix -Q carma256.pal,0,256 -P carma256.pal -O image -o tests\index_8.pix
:: if transparency/id#0 has to be excluded, then base/range for a 256 colour palette would be 1,255

:: In the following, I first convert to RGB_888 to be sure TEXCONV doesn't use the alpha at all.
:: texconv-win ref_8888.tga -c BR_PMT_RGB_888 -n index_8.pix -Q carma256.pal,1,254 -P carma256.pal -O pixelmap -o index_8.pix
:: texconv-win ref_8888.tga -c BR_PMT_BGR_555 -n bgr555.pix -O image -o bgr555.pix

:: Desperate tries to get INDEX_4 and verify the result but texconv-win (1.1 '97) just doesn't support
:: converting to that format. Must use an older DOS version of TEXCONV.
:: texconv-win ref_pal16.tga -n index_4.pix -Q carma_16.pal,0,16 -P carma_16.pal -c BR_PMT_INDEX_4 -O image -o index_4.pix
:: texconv-win ref_index4.pix -n index_4.pix -P carma_16.pal -c BR_PMT_RGB_888 -o index4.tga

:: Generate mipmaps woo :
:: texconv-win ref_8888.tga -n rgb_888.pix -c BR_PMT_RGB_888 -N -O image -o rgb_888+mips(0x3D).pix
:: adding the -P CARMA256.PAL despite the image already converted to it is to make sure texconv
:: includes the original palette with its correct identifier in the pixelmap.
:: an again, converting to RGB_888 to be sure it doesn't use the alpha (it will).
texconv-win ref_8888.tga -c BR_PMT_RGB_888 -n index_8.pix -Q CARMA256.PAL,0,256 -N -P CARMA256.PAL -O pixelmap -o index_8+pal+mips(0x3D).pix
:: converting back to tga to verify it didn't mess up the top map
texconv-win index_8+pal+mips(0x3D).pix -c BR_PMT_RGB_888 -o index_8+pal+mips(0x3D).tga