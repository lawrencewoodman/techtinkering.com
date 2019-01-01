source -directory [dir plugins] layout.tcl
source -directory [dir plugins] posts.tcl
source -directory [dir plugins] www.tcl

posts::generate

set destination [www::makeDestination articles index.html]
set posts [posts::sort [collection get articles-posts]]
set params [dict create url [www::url articles index.html] posts $posts]
write $destination [layout::render post-list.tpl $params]
