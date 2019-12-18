!* commandSubst true variableSubst true
! source -directory [dir plugins] posts.tcl
! source -directory [dir plugins] www.tcl
! source -directory [dir plugins] include.tcl
! set title [getparam title]
! set date [getparam date]
!#
!# Redirect if necessary
! if {[getparam -default "" redirectTo] ne ""} {
    <script language="javascript" type="text/javascript">
      window.location.replace("[getparam redirectTo]")
    </script>

    <div class="row margin-buffer">
      <div class="col-md-12">
        <div class="articleRedirected">
          <h1>Old Article</h1>
          <p>This is an old article which is only being kept for historical purposes.</p>

          <p>Please navigate and update any links to the new article: <a href="[getparam redirectTo]">[getparam redirectName]</a>.</p>
        </div>
      </div>
   </div>
! }
!#
<div class="row margin-buffer">
  <div class="col-md-12">
    <article itemscope itemtype="http://schema.org/BlogPosting">
      <header>
        <a href="[www::url [getparam url]]" title="$title">
          <h1 itemprop="headline name">$title</h1>
        </a>
        <div class="pull-right">
          [include simple_share_buttons.html]
        </div>
        <div>
!         if {![getparam -default false hideDate]} {
            <time itemprop="datePublished"
                  datetime="[clock format $date -format {%Y-%m-%d}]">
              [clock format $date -format {%e %B %Y}]
            </time>
            &nbsp; / &nbsp;
!         }
          <span itemscope itemprop="publisher"
                itemtype="http://schema.org/Organization">
            <meta itemprop="name" content="TechTinkering" />
            <meta itemprop="url" content="http://techtinkering.com" />
          </span>
          <span itemscope itemprop="author" itemtype="http://schema.org/Person">
            <a rel="author" itemprop="url" href="[getparam author url]">
              <span itemprop="name">[getparam author name]</span>
            </a>
          </span>
          &nbsp; / &nbsp;
!         foreach tag [getparam tags] {
            <a href="[www::url "/articles/tag/[posts::tagToDirName $tag]/"]">$tag</a>
            &nbsp; &nbsp;
!         }
        </div>
      </header>
      <br />
      <div itemprop="articleBody">
        [getparam content]
      </div>
    </article>
  </div>
</div>

! if {[getparam -default false hideLicence]} {
  <div class="row">
    <div class="col-md-12">
      <hr />
    </div>
  </div>
! } else {
  <div class="row">
    <div class="col-md-12">
      <div id="cclicence">
        <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">
          <img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" />
        </a>
        <br />
        <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">$title</span>
        by <a xmlns:cc="http://creativecommons.org/ns#" href="[www::url -canonical [getparam url]]" property="cc:attributionName" rel="cc:attributionURL">[getparam author name]</a>
       is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
      </div>
    </div>
  </div>
! }

! if {[llength [getparam relatedPosts]] >= 1} {
    <div class="row">
      <div class="col-md-12">
        <h2>Related Articles</h2>
      </div>
    </div>
!   set postListParams [dict create posts [getparam relatedPosts] maxPosts 5]
    [ornament -params $postListParams -directory [dir includes] -file post_list.html]
! }

<div class="row">
  <div class="col-md-12">
    [include email_subscription.html]
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <h2>Comments</h2>
    <div id="disqus_thread"></div>
    <script type="text/javascript">
      var disqus_shortname = 'techtinkering';
      var disqus_identifier = '[www::url [getparam url]]';
      var disqus_url = '[www::url -full [getparam url]]';
!* commandSubst false variableSubst false

      /* * * DON'T EDIT BELOW THIS LINE * * */
      (function() {
          var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
          dsq.src = 'https://' + disqus_shortname + '.disqus.com/embed.js';
          (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
      })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
    <a href="https://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>
  </div>
</div>
