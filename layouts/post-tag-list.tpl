!* commandSubst true
! source -directory [dir plugins] www.tcl
! source -directory [dir plugins] include.tcl
<div class="row margin-buffer">
  <div class="col-md-12">
    [include main_tags.html]
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <a id="btn-view-all" class="pull-right btn btn-success btn-lg" href="/articles/">View All Articles</a>
    <div id="indexHeader">[getparam tag]</div>
    [getparam -default "" summaryHTML]
    <hr />
  </div>
</div>

! set postListParams [dict create posts [getparam posts] maxPosts 0]
[ornament -params $postListParams -directory [dir includes] -file post_list.html]

<div class="row">
  <div class="col-md-12">
    [include email_subscription.html]
  </div>
</div>
