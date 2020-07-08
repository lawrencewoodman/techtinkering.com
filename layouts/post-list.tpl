!* commandSubst true
! source -directory [dir plugins] posts.tcl
! source -directory [dir plugins] www.tcl
! source -directory [dir plugins] include.tcl
<div class="margin-buffer">
  [include main_tags.html]
</div>

<div id="index-header">All Articles</div>
<hr />

! set posts [posts::sort [collection get articles-posts]]
! set postListParams [dict create posts $posts maxPosts 0]
[ornament -params $postListParams -directory [dir includes] -file post_list.html]

[include email_subscription.html]
