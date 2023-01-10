/*
 * Create Amazon Affiliate Links
 */

function amznBannerInit() {
  console.log("Amazon Banner - from uk");
  if (1) {
    var amznAd1 = '<a href="https://www.amazon.co.uk/Hackers-Heroes-Computer-Revolution-Anniversary/dp/1449388396?_encoding=UTF8&qid=1672040080&sr=1-1&linkCode=li2&tag=techtinkering-21&linkId=ffb2fd87149bc865616b52259155d599&ref_=as_li_ss_il" target="_blank"><img border="0" src="//ws-eu.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=1449388396&Format=_SL160_&ID=AsinImage&MarketPlace=GB&ServiceVersion=20070822&WS=1&tag=techtinkering-21" ><' + '/a><img src="https://ir-uk.amazon-adsystem.com/e/ir?t=techtinkering-21&l=li2&o=2&a=1449388396" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />';
    var amznAd2 = '<a href="https://www.amazon.co.uk/Computing-Middle-Ages-Trenches-1955-1983/dp/1403315175?crid=3FX2FL2TQWGF0&keywords=computing+in+the+middle+ages&qid=1672041155&s=books&sprefix=computing+in+the+middle+ages%2Cstripbooks%2C95&sr=1-3&linkCode=li2&tag=techtinkering-21&linkId=f362f9946e31cf49e9585d6baa718b36&ref_=as_li_ss_il" target="_blank"><img border="0" src="//ws-eu.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=1403315175&Format=_SL160_&ID=AsinImage&MarketPlace=GB&ServiceVersion=20070822&WS=1&tag=techtinkering-21" ><' + '/a><img src="https://ir-uk.amazon-adsystem.com/e/ir?t=techtinkering-21&l=li2&o=2&a=1403315175" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />';
    var amznAd3 = '<a href="https://www.amazon.co.uk/Electronic-Brains-Stories-Dawn-Computer/dp/1862078394?crid=1CD8RRU4NYXDU&keywords=electronic+brains&qid=1672042674&s=books&sprefix=electronic+brains%2Cstripbooks%2C87&sr=1-6&linkCode=li2&tag=techtinkering-21&linkId=13be90b6bfdd3900efa71056a432bc66&ref_=as_li_ss_il" target="_blank"><img border="0" src="//ws-eu.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=1862078394&Format=_SL160_&ID=AsinImage&MarketPlace=GB&ServiceVersion=20070822&WS=1&tag=techtinkering-21" ><' + '/a><img src="https://ir-uk.amazon-adsystem.com/e/ir?t=techtinkering-21&l=li2&o=2&a=1862078394" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />';
    var amznAd4 = '<a href="https://www.amazon.co.uk/What-Dormouse-Said-Counterculture-Computerindustry/dp/0143036769?crid=1CIQCNJH0T6CL&keywords=what+the+dormouse+said&qid=1672212862&s=books&sprefix=what+the+doormouse+said%2Cstripbooks%2C1573&sr=1-1&linkCode=li2&tag=techtinkering-21&linkId=400220bd90af6af19d12e7e636a909c1&ref_=as_li_ss_il" target="_blank"><img border="0" src="//ws-eu.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=0143036769&Format=_SL160_&ID=AsinImage&MarketPlace=GB&ServiceVersion=20070822&WS=1&tag=techtinkering-21" ><' + '/a><img src="https://ir-uk.amazon-adsystem.com/e/ir?t=techtinkering-21&l=li2&o=2&a=0143036769" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />';
    /* TODO: Rename amznBanner as not a banner */
    amznBanner='<div class="amazonImageGroupContainer">';
    amznBanner+= '<div class="amazonImageGroupDesktop">';
    amznBanner+= '<div class="amazonImageSmall">';
    amznBanner+= amznAd1;
    amznBanner+= '<'+'/div>';
    amznBanner+= '<div class="amazonImageSmall">';
    amznBanner+= amznAd2;
    amznBanner+= '<'+'/div>';
    amznBanner+= '<div class="amazonImageSmall">';
    amznBanner+= amznAd3;
    amznBanner+= '<'+'/div>';
    amznBanner+= '<div class="amazonImageSmall">';
    amznBanner+= amznAd4;
    amznBanner+= '<'+'/div>';
    amznBanner+= '<'+'/div>';

    amznBanner+= '<div class="amazonImageGroupMobile">';
    amznBanner+= '<div class="amazonImageSmall">';
    amznBanner+= amznAd1;
    amznBanner+= '<'+'/div>';
    amznBanner+= '<div class="amazonImageSmall">';
    amznBanner+= amznAd2;
    amznBanner+= '<'+'/div>';
    amznBanner+= '<div class="amazonImageSmall">';
    amznBanner+= amznAd3;
    amznBanner+= '<'+'/div>';
    amznBanner+= '<'+'/div>';

    amznBanner+= 'Recommended Books on Amazon';
    amznBanner+= '<'+'/div>';
  } else {
    // Amazon Prime Video Banner 728x90 and 300x250
    amznBanner='<div class="amazonBannerDesktop"><iframe src="https://rcm-eu.amazon-adsystem.com/e/cm?o=2&p=48&l=ur1&category=piv&banner=0E183RXMV88X6J8GJ002&f=ifr&linkID=a2c37aae0561f075af3356504493bdf0&t=techtinkering-21&tracking_id=techtinkering-21" width="728" height="90" scrolling="no" border="0" marginwidth="0" style="border:none;" frameborder="0" sandbox="allow-scripts allow-same-origin allow-popups allow-top-navigation-by-user-activation"><' + '/iframe><' +'/div><div class="amazonBannerMobile"><iframe src="https://rcm-eu.amazon-adsystem.com/e/cm?o=2&p=12&l=ur1&category=piv&banner=070GKT77WVHAHSRTHK02&f=ifr&linkID=0dc57b53bcc8f7ab67a385d51155e57a&t=techtinkering-21&tracking_id=techtinkering-21" width="300" height="250" scrolling="no" border="0" marginwidth="0" style="border:none;" frameborder="0" sandbox="allow-scripts allow-same-origin allow-popups allow-top-navigation-by-user-activation"><' + '/iframe><' + '/div>';
  }
}
