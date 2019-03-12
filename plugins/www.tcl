namespace eval www {
  namespace export {[a-z]*}
}

# Prefix url with plugins > www > baseurl
# Options:
#   -full        Take prefixed url and prefix with plugins > www > url
#   -canonical   Take prefixed url and prefix it with plugins > www > url
#                and remove the index.html
proc www::url {args} {
  array set options {canonical 0 full 0}
  while {[llength $args]} {
    switch -glob -- [lindex $args 0] {
      -can*   {set options(canonical) 1 ; set args [lrange $args 1 end]}
      -full   {set options(full) 1 ; set args [lrange $args 1 end]}
      --      {set args [lrange $args 1 end] ; break}
      -*      {error "url: unknown option [lindex $args 0]"}
      default break
    }
  }
  if {[llength $args] == 0} {
    return -code error "url: invalid number of arguments"
  }
  set urlParts [lmap p $args {string trimleft $p "/"}]
  set url [join $urlParts "/"]
  if {[getvar plugins www baseurl] ne ""} {
    set url "[getvar plugins www baseurl]/$url"
  }
  set url "/$url"
  if {$options(canonical) || $options(full)} {
    set url [getvar plugins www url]$url
  }
  if {$options(canonical)} {
    # Remove index.html if present
    set indexPos [string last "index.html" $url]
    if {$indexPos >= 0 } {
      set url [string range $url 0 $indexPos-1]
    }
  }
  return $url
}

proc www::makeDestination {args} {
  return [file join [dir destination] [urlToPath [var baseurl]] {*}$args]
}

proc www::urlToPath {url} {
  if {[string trim $url] eq ""} {return {}}
  return [file join {*}[split $url "/"]]
}

test www::urlToPath {{ns t} {
  set cases [list \
    [dict create input {bob/harry} result [file join bob harry]] \
    [dict create input {bob/harry/nerris} \
                 result [file join bob harry nerris]] \
    [dict create input {bob/harry/nerris/} \
                 result [file join bob harry nerris]] \
    [dict create input {} result {}] \
    [dict create input { } result {}] \
  ]
  testCases $t $cases {{ns case} {dict with case {${ns}::urlToPath $input}}}
}}

proc www::var {args} {
  array set options {}
  while {[llength $args]} {
    switch -glob -- [lindex $args 0] {
      -default {set args [lassign $args - options(default)]}
      --      {set args [lrange $args 1 end] ; break}
      -*      {error "var: unknown option [lindex $args 0]"}
      default break
    }
  }
  set getCmd getvar
  if {[info exists options(default)]} {
    lappend getCmd -default $options(default)
  }
  {*}$getCmd plugins www {*}$args
}
