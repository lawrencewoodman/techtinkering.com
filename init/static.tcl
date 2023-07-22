source -directory [dir plugins] www.tcl
set cssDir [dir content static css]
file copy [file join $cssDir *.css] \
          [www::makeDestination css]

set imagesDir [dir content static images]
file copy [file join $imagesDir *.png] \
          [www::makeDestination images]

set imgDir [dir content static img]
file copy [file join $imagesDir *.png] \
          [www::makeDestination img]

#set contactIconsDir [dir content static img contact_icons]
#file copy [file join $contactIconsDir *.svg] \
#          [www::makeDestination img contact_icons]

set articleImagesDir [dir content static img articles]
file copy [file join $articleImagesDir *.png] \
          [file join $articleImagesDir *.jpg] \
          [file join $articleImagesDir *.gif] \
          [www::makeDestination img articles]

set articleWalnutCreekCDRdump10ImagesDir \
    [dir content static img articles walnut_creek_cd rdump10]
file copy [file join $articleWalnutCreekCDRdump10ImagesDir *.png] \
          [www::makeDestination img articles walnut_creek_cd rdump10]

set articleWalnutCreekCDRlegraf1ImagesDir \
    [dir content static img articles walnut_creek_cd rlegraf1]
file copy [file join $articleWalnutCreekCDRlegraf1ImagesDir *.png] \
          [www::makeDestination img articles walnut_creek_cd rlegraf1]

set articleWalnutCreekCDEnterprsC64GfxImagesDir \
    [dir content static img articles walnut_creek_cd enterprs.c64.gfx]
file copy [file join $articleWalnutCreekCDEnterprsC64GfxImagesDir *.png] \
          [www::makeDestination img articles walnut_creek_cd enterprs.c64.gfx]

set socialImagesDir [dir content static img social_images]
file copy [file join $socialImagesDir *.png] \
          [file join $socialImagesDir *.jpg] \
          [www::makeDestination img social_images]

#set faviconsDir [dir content static favicons]
#file copy [file join $faviconsDir *.ico] \
#          [file join $faviconsDir *.png] \
#          [file join $faviconsDir *.xml] \
#          [www::makeDestination]


set articleVideoDir [dir content static video articles]
file copy [file join $articleVideoDir *.mp4] \
          [www::makeDestination video articles]


set faviconsDir [dir content static favicons]
file copy [file join $faviconsDir *.ico] [www::makeDestination]

set jsDir [dir content static js]
file copy [file join $jsDir *.js] [www::makeDestination js]

set downloadsDir [dir content static downloads]
file copy [file join $downloadsDir *.gz] \
          [file join $downloadsDir *.lbr] \
          [file join $downloadsDir *.patch] \
          [www::makeDestination downloads]

set staticDir [dir content static]
file copy [file join $staticDir CNAME] \
          [file join $staticDir .nojekyll] \
          [www::makeDestination]
