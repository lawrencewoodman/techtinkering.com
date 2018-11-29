source -directory [dir plugins] posts.tcl
source -directory [dir plugins] www.tcl

set destination [www::makeDestination feed.xml]
set posts [posts::sort [collection get articles-posts]]
set params [dict create posts $posts]
set content [ornament -params $params -directory [dir content] -file feed.xml]
write $destination $content
