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
                       $tagLayout $srcDir $url
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
proc posts::makeURL {url filename} {
  set filename [file tail $filename]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    return "[www::url $url $year $month $day $titleDir]/"
  }
  return -code error "makeURL: invalid filename: $filename"
}


# Sort posts in decreasing date order
proc posts::sort {posts} {
  return [lsort -command [namespace which CompareDate] -decreasing $posts]
}


proc posts::tagToDirName {tag} {
 return [string tolower [regsub -all {[^[:alnum:]_-]} $tag {}]]
}


proc posts::GenerateTagPages {tagLayout files url {tags {}}} {
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
  url
} {
  # TODO: sort in date order
  set files [read -directory $srcDir details.list]

  set files [lmap file $files {
    dict set file destination [
      MakeDestination $url [dict get $file filename]
    ]
    dict set file tags [lsort [dict get $file tags]]
    dict set file url  [
      makeURL $url [dict get $file filename]\
    ]
    dict set file date [posts::makeDate $file]
    dict set file menuOption article
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
  GenerateTagPages $tagLayout $files $url $tags
}


proc posts::MakeExcerpt {partialContent} {
  return [string range [strip_html $partialContent] 0 200]
}


# url is where the destination should be based off, such as blog
proc posts::MakeDestination {url filename} {
  set filename [file tail $filename]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    return [www::makeDestination $url $year $month $day $titleDir index.html]
  }
  # TODO: Raise an error
}
