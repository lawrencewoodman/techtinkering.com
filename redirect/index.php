<?php

// Array mapping article ids to new descriptive urls
$articleID = array(
  38 => "/2011/04/16/mida-a-microdata-parser-extractor-library-for-ruby",
  37 => "/2011/02/15/a-jekyll-plugin-to-display-ratings-as-star-images",
  36 => "/2010/06/15/the-national-museum-of-computing-at-bletchley-park",
  35 => "/2010/05/06/xace-is-back-in-active-development-and-looking-for-contributors",
  34 => "/2010/04/16/introducing-textpix-v0-1",
  33 => "/2010/02/14/getting-colour-ansi-emulation-to-work-properly-when-connecting-to-a-bbs-with-telnet-under-linux",
  32 => "/2009/12/02/setting-up-a-beowulf-cluster-using-open-mpi-on-linux",
  31 => "/2009/08/11/my-top-10-classic-text-mode-bsd-games",
  30 => "/2009/07/14/running-4k-fortran-on-a-dec-pdp8",
  29 => "/2009/06/16/a-quickstart-guide-to-editing-paper-tape-with-the-symbolic-tape-editor-on-the-dec-pdp-8",
  28 => "/2009/06/03/book-review-electronic-brains-stories-from-the-dawn-of-the-computer-age-by-mike-hally",
  27 => "/2009/05/26/emulating-a-dec-pdp8-with-simh",
  26 => "/2009/05/15/improving-the-standard-subleq-oisc-architecture",
  25 => "/2009/05/06/connecting-a-parallel-printer-to-a-modern-linux-machine-using-a-logilink-usb-to-parallel-cable",
  24 => "/2009/04/30/an-introduction-to-corewar",
  23 => "/2009/04/23/the-smallest-communication-program-in-the-world",
  22 => "/2009/03/29/hello-world-in-subleq-assembly",
  21 => "/2009/03/18/an-introduction-to-test-driven-development",
  20 => "/2009/03/05/the-subleq-urisc-oisc-architecture",
  19 => "/2009/02/12/xace-a-jupiter-ace-emulator-for-unix-patched-to-correct-garbled-display",
  18 => "/2009/01/26/book-review-the-mythical-man-month-essays-on-software-engineering-by-frederick-p-brooks-jr",
  17 => "/2008/12/16/bouncing-babies",
  16 => "/2008/12/08/chinese-man-spotted-on-tissue",
  15 => "/2008/11/24/my-top-10-commodore-64-demos",
  14 => "/2008/11/13/beneath-a-steel-sky-my-favourite-graphical-adventure-game",
  13 => "/2008/11/12/how-to-file-good-bug-reports",
  12 => "/2008/11/10/using-scummvm-to-play-classic-adventure-games",
  11 => "/2008/11/05/writing-my-first-program-to-toggle-in-to-the-imsai-8080",
  10 => "/2008/10/29/using-the-latest-z80pack-version-1-17-to-emulate-an-altair-8800-or-imsai-8080-using-the-new-graphical-frontpanel",
  9 => "/2008/10/28/is-this-steamer-really-not-to-be-used-by-girls",
  8 => "/2008/10/24/using-dosbox-to-run-dos-games-and-applications",
  7 => "/2008/10/22/installing-the-hi-tech-z80-c-compiler-for-cpm",
  6 => "/2008/10/21/installing-zde-1-6-a-programmers-editor-for-cpm",
  5 => "/2008/10/17/setting-up-z80pack-to-create-an-emulated-cpm-system",
  4 => "/2008/10/14/pdp-8-in-three-days-of-the-condor",
  3 => "/2008/10/07/book-review-fundamentals-of-operating-systems-by-a-m-lister",
  2 => "/2008/09/16/how-to-share-an-ssl-certificate-and-still-use-cookies",
  1 => "/2008/08/08/is-cobol-really-understandable-after-14-years"
);

if (array_key_exists($_GET[id], $articleID)) {
	// Redirect to new post page
	header("Location: http://techtinkering.com/".$articleID[$_GET[id]]);
} elseif ($_GET[tag]) {
  header("Location: http://techtinkering.com/tag/".$_GET[tag]);
} else {
  header("Location: http://techtinkering.com/");
}
exit;

?>

