namespace eval posts {
  namespace export {[a-z]*}
  namespace ensemble create
  source -directory [dir plugins] www.tcl
  source -directory [dir plugins] layout.tcl
}


proc posts::generate {} {
  foreach postDesc [getvar plugins posts] {
    dict with postDesc {
      ProcessPostsDesc $collectionPrefixName $postLayout \
                       $tagLayout $srcDir $postURLStyle
    }
  }
}


proc posts::makeDate {post} {
  set date ""
  if {[dict exists $post date]} {
    set date [dict get $post date]
  }
  if {$date ne ""} {
    return [clock scan $date -format {%Y-%m-%d}]
    # TODO: output warning if can't read format
  } elseif {[dict exists $post filename]} {
    set filename [file tail [dict get $post filename]]
    set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-.*$} \
                   $filename match year month day \
    ]
    if {$ok} {
      return [clock scan "$year-$month-$day" -format {%Y-%m-%d}]
    }
  } else {
    # TODO: output warning if can't read format
    return [clock seconds]
  }
}


# url is where the url should be based off, such as blog
proc posts::MakeURL {postURLStyle file} {
 set filename [file tail [dict get $file filename]]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    if {[dict exists $file postURLStyle]} {
      set postURLStyle [dict get $file postURLStyle]
    }
    # TODO make this properly dynamic
    switch $postURLStyle {
      "/articles/@title/" {
        return "[www::url articles $titleDir]/"
      }
      "/@year/@month/@day/@title/" {
        return "[www::url $year $month $day $titleDir]/"
      }
      default {
        return -code error "unknown postURLStyle: $postURLStyle"
      }
    }
  }
  return -code error "MakeURL: invalid filename: $filename"
}


# Sort posts in decreasing date order
proc posts::sort {posts} {
  return [lsort -command [namespace which CompareDate] -decreasing $posts]
}


proc posts::tagToDirName {tag} {
 return [string tolower [regsub -all {[^[:alnum:]_-]} $tag {}]]
}


proc posts::GenerateTagPages {srcDir tagLayout files url {tags {}}} {
  set tagDetails [read -directory $srcDir tags.details]
  foreach tag $tags {
    set tagFiles [list]
    foreach file $files {
      if {![dict exists $file tags]} {
        continue
      }
      if {[lsearch [dict get $file tags] $tag] >= 0} {
        lappend tagFiles $file
      }
    }
    set tagDirName [tagToDirName $tag]
    set destination [
      www::makeDestination {*}[www::urlToPath $url] tag $tagDirName index.html
    ]
    set params [dict create \
      tag $tag posts $tagFiles \
      url [www::url $url tag $tagDirName index.html] \
      title "Articles tagged with: $tag" \
    ]
    if {[dict exists $tagDetails $tagDirName]} {
      set summary [dict get $tagDetails $tagDirName summary]
      set summaryHTML [markdown $summary]
      dict set params summaryHTML $summaryHTML
      dict set params summary [strip_html $summaryHTML]
    }
    write $destination [layout::render $tagLayout $params]
  }
}


proc posts::CollectTags {collectionPrefixName files} {
  set allTags [list]
  foreach file $files {
    foreach tag [dict get $file tags] {
      if {[lsearch $allTags $tag] == -1} {
        lappend allTags $tag
        ::collection add "$collectionPrefixName-tags" $tag
      }
    }
  }
  return $allTags
}


# Return any posts related to the supplied post. This is done by looking
# at the tags.
proc posts::MakeRelated {posts post} {
  set postTags [dict get $post tags]
  set relatedPostStats [lmap oPost $posts {
    set numTagsMatch 0
    foreach oTag [dict get $oPost tags] {
      if {[lsearch $postTags $oTag] >= 0 &&
          [dict get $post filename] ne [dict get $oPost filename]} {
        incr numTagsMatch
      }
    }
    if {$numTagsMatch == 0} {
      continue
    }
    list $numTagsMatch $oPost
  }]
  set relatedPostStats [lsort -decreasing -command {apply {{a b} {
    set aNumTags [lindex $a 0]
    set bNumTags [lindex $b 0]
    set numTagsDiff [expr {$aNumTags - $bNumTags}]
    if {$numTagsDiff != 0} {
      return $numTagsDiff
    }
    return [expr {[dict get [lindex $a 1] date] -
                  [dict get [lindex $b 1] date]}]
  }}} $relatedPostStats]
  return [lmap x $relatedPostStats { lindex $x 1 }]
}


proc posts::CompareDate {a b} {
  return [expr {[dict get $a date] - [dict get $b date]}]
}


proc posts::ProcessPostsDesc {
  collectionPrefixName
  postLayout
  tagLayout
  srcDir
  postURLStyle
} {
  # TODO: sort in date order
  set files [read -directory $srcDir posts.details]

  set files [lmap file $files {
    dict set file destination [
      MakeDestination $postURLStyle $file
    ]
    dict set file tags [lsort [dict get $file tags]]
    dict set file url  [MakeURL $postURLStyle $file]
    dict set file date [posts::makeDate $file]
    set content [
      ornament -params $file -directory $srcDir -file [dict get $file filename]
    ]
    dict set file content [markdown -- $content]
    dict set file summary [MakeExcerpt [dict get $file content]]
    set file
  }]

  set files [lmap file $files {
    dict set file relatedPosts [MakeRelated $files $file]
    collection add "$collectionPrefixName-posts" $file
    write [dict get $file destination] \
          [layout::render $postLayout $file [dict get $file content]]
    set file
  }]
  set tags [CollectTags "$collectionPrefixName-tags" $files]
  # TODO: Must make articles dynamic like postURLStyle
  GenerateTagPages $srcDir $tagLayout $files articles $tags
}


proc posts::MakeExcerpt {partialContent} {
  return [string range [strip_html $partialContent] 0 200]
}


# url is where the destination should be based off, such as blog
proc posts::MakeDestination {postURLStyle file} {
  set filename [file tail [dict get $file filename]]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    if {[dict exists $file postURLStyle]} {
      set postURLStyle [dict get $file postURLStyle]
    }
    # TODO make this properly dynamic
    switch $postURLStyle {
      "/articles/@title/" {
        return [www::makeDestination articles $titleDir index.html]
      }
      "/@year/@month/@day/@title/" {
        return [
          www::makeDestination $year $month $day $titleDir index.html
        ]
      }
      default {
        return -error "unknown postURLStyle: $postURLStyle"
      }
    }
  }
  # TODO: Raise an error
}
