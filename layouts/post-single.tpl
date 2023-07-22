!* commandSubst true variableSubst true
! source -directory [dir plugins] posts.tcl
! source -directory [dir plugins] www.tcl
! source -directory [dir plugins] include.tcl
! set title [getparam title]
! set date [getparam date]
! set url [www::url [getparam url]]
! set fullURL [www::url -full [getparam url]]
!#
!# Redirect if necessary
! if {[getparam -default "" redirectTo] ne ""} {
    <script language="javascript" type="text/javascript">
      window.location.replace("[getparam redirectTo]")
    </script>

    <div class="margin-buffer articleRedirected">
      <h1>Old Article</h1>
      <p>This is an old article which is only being kept for historical purposes.</p>

      <p>Please navigate and update any links to the new article: <a href="[getparam redirectTo]">[getparam redirectName]</a>.</p>
    </div>
! }
!#
<div class="margin-buffer">
! if {[getparam -default 0 rating] > 0} {
    <article itemscope itemtype="http://schema.org/Review">
    <meta itemprop="itemReviewed" content="[getparam itemReviewed]" />

! } else {
    <article itemscope itemtype="http://schema.org/BlogPosting">
! }
! if {[getparam -default "" socialImg] != ""} {
    <meta itemprop="image"
         content="[www::url -full "/img/social_images/[getparam socialImg]"]" />
! }
      <header>
        <a href="[www::url [getparam url]]" title="$title">
          <h1 itemprop="headline name">$title</h1>
        </a>
        <div>
!         if {![getparam -default false hideDate]} {
            <time itemprop="datePublished"
                  datetime="[clock format $date -format {%Y-%m-%d}]">
              [clock format $date -format {%e %B %Y}]
            </time>
!         }
          <span itemscope itemprop="publisher"
                itemtype="http://schema.org/Organization">
            <meta itemprop="name" content="TechTinkering" />
            <meta itemprop="url" content="https://techtinkering.com" />
          </span>
          <span itemscope itemprop="author" itemtype="http://schema.org/Person">
            <a rel="author" itemprop="url" href="[getparam author url]">
              <span itemprop="name">[getparam author name]</span>
            </a>
          </span>
! if {[getparam -default 0 rating] > 0} {
        &nbsp; / &nbsp; Rating:
        <span itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
          <meta itemprop="worstRating" content="1" />
          <span itemprop="ratingValue">[expr {int([getparam rating])}]</span>/<span itemprop="bestRating">5</span>
        </span>
! }

          <ul class="tags">
!           foreach tag [getparam tags] {
              <li>#<a href="[www::url "/articles/tag/[posts::tagToDirName $tag]/"]">$tag</a></li>
!           }
          </ul>
        </div>
      </header>

!     if {[getparam -default 0 rating] > 0} {
        <div itemprop="reviewBody">
!     } else {
        <div itemprop="articleBody">
!     }
        [getparam content]
      </div>
    </article>
</div>

! if {[getparam -default false hideLicence]} {
  <div>
!   if {[getparam -default "" extraDisclaimer] ne ""} {
      <div id="cclicence" style ="padding-top: 0.5em">
        [getparam extraDisclaimer]
      </div>
!   } else {
      <hr />
!   }
  </div>
! } else {
  <div id="cclicence">
    <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">
      <img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" />
    </a>
    <br />
    <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">$title</span>
    by <a xmlns:cc="http://creativecommons.org/ns#" href="[www::url -canonical [getparam url]]" property="cc:attributionName" rel="cc:attributionURL">[getparam author name]</a>
   is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
   [getparam -default "" extraDisclaimer]
  </div>
! }


! if {[www::var -default true enableDisqus]} {
  <div>
    <h2>Comments</h2>
    <div id="disqus_thread"></div>
    <script type="text/javascript">
      var disqus_shortname = 'techtinkering';
      var disqus_identifier = '$url';
      var disqus_url = '$fullURL';
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
!* commandSubst true variableSubst true
! } else {
  <div class="discuss">
    <h2 style="margin-top:0;">Share This Post</h2>
    [ornament -params [getparam] -directory [dir includes] -file simple_share_buttons_text.html]

    <h2>Feedback/Discuss</h2>
    [ornament -params [getparam] -directory [dir includes] -file feedback.html]
  </div>
! }


! if {[llength [getparam relatedPosts]] >= 1} {
    <div>
    <h2>Related Articles</h2>
!   set postListParams [dict create posts [getparam relatedPosts] maxPosts 5]
    [ornament -params $postListParams -directory [dir includes] -file post_list.html]
    </div>
! }
