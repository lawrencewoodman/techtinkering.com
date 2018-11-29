source -directory plugins layout.tcl
source -directory plugins www.tcl

set files {index.html 404.html}
foreach filename $files {
  set destination [www::makeDestination $filename]
  set params [dict create menuOption home url /$filename]
  set content [ornament -params $params -directory content -file $filename]
  write $destination [layout::render default.tpl $params $content]
}
