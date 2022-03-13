!* commandSubst true
! source -directory [dir plugins] www.tcl
! source -directory [dir plugins] include.tcl
<div class="margin-buffer">
  [include main_tags.html]
</div>

<div>
  <a class="view-all pull-right" href="/articles/">View All Articles</a>
  <div id="index-header">[getparam tag]</div>
  [getparam -default "" summaryHTML]
  <hr />
</div>

<script>
  if (isUserFromUK()) {
    document.write(amznBanner);
  }
</script>

! set postListParams [dict create posts [getparam posts] maxPosts 0]
[ornament -params $postListParams -directory [dir includes] -file post_list.html]

<div class="text-center">
  <a class="view-all" href="/articles/">View All Articles</a>
</div>
