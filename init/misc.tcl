source -directory plugins layout.tcl
source -directory plugins www.tcl


proc makeContent {dir file} {
  return [markdown -directory $dir -file [dict get $file filename]]
}

proc processDir {args} {
  set files [read -directory [dir content {*}$args] details.list]
  set files [lmap file $files {
    dict set file url [www::url {*}[dict get $file destination]]
    dict set file destination [
      www::makeDestination {*}[dict get $file destination]
    ]
    set file
  }]

  foreach file $files {
    set content [makeContent [dir content {*}$args] $file]
    set params [dict merge [dict create files $files] $file]
    write [dict get $file destination] \
          [layout::render default.tpl $params $content]
  }
}

processDir misc
