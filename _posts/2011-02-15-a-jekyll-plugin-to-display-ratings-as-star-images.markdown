---
layout: article
title: "A Jekyll Plugin to Display Ratings as Star Images"
summaryPic: small_star_ratings.jpg
summaryPicTitle: "star_rating filter in actin on http://trustafriend.com"
tags:
  - Jekyll
  - Liquid
  - Ruby
  - Web Development
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I have been using <a href="http://jekyllrb.com/">Jekyll</a> a lot recently on the <a href="http://trustafriend.com">Trust a Friend</a> website and found the need to display a rating as a series of stars.  Initially I implemented this in JavaScript, which worked fine, but I like to limit the amount of JavaScript on my sites.  I could have done this with some straight _Liquid_ but it would have been quite messy, so I decided to write a plugin for Jekyll.

<h2>The Code</h2>
I had never programmed in Ruby before writing this plugin, so I'm sure it isn't written in the best Ruby style, but it works and therefore I think it is worth sharing.  The code consists of an additional definition to the Filters module to provide a filter called `star_rating`.  The latest version of the code can be found under my <a href="http://github.com/LawrenceWoodman">GitHub</a> account in the <a href="https://github.com/LawrenceWoodman/star_rating-liquid_filter">star_rating-liquid_filter</a> repository.

At the time of writing, the <strong>star_rating.filter.rb</strong> plugin file looks like the following:
{% highlight ruby %}
######################################################################
# A filter plugin for Jekyll to display ratings as a series
# of nought to five star images.
#---------------------------------------------------------------------
# License:
# Copyright (c) 2011, Lawrence Woodman
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or 
# without modification, are permitted provided that the following 
# conditions are met:
#
#    * Redistributions of source code must retain the above 
#      copyright notice, this list of conditions and the following 
#      disclaimer.
#    * Redistributions in binary form must reproduce the above 
#      copyright notice, this list of conditions and the following 
#      disclaimer in the documentation and/or other materials 
#      provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
# COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
######################################################################

module Jekyll
  module Filters

    # Location of the star images from root of website
    Star_imagesLoc = "/images"

    # The format of the img tag used by % method
    Star_imageTag = "<img src=\"#{Star_imagesLoc}/%s\" alt=\"%s\" \>"

    # Displays the rating as a series of stars
    def star_rating(rating)

      wholeStars = rating.floor
      if (rating - wholeStars > 0.5)
        wholeStars += 1
      end
      halfStar = (rating - wholeStars == 0.5 ? 1 : 0)
      clearStars = 5 - (wholeStars + halfStar)

      ratingAltText = "%.1f/5.0" % [rating]

      htmlOutput = String.new
      wholeStars.times do
        htmlOutput += Star_imageTag % ["star_filled.png", "#{ratingAltText}"]
        ratingAltText = ""
      end

      if (halfStar == 1)
        htmlOutput += Star_imageTag % ["star_half.png", "#{ratingAltText}"]
        ratingAltText = ""
      end

      clearStars.times do
        htmlOutput += Star_imageTag % ["star_clear.png", "#{ratingAltText}"]
        ratingAltText = ""
      end

      return htmlOutput
    end
  end
end
{% endhighlight %}

<h2>Installation</h2>
Please refer to the instructions in the repository, but to give you an idea of
how easy it is, here are the current instructions:
_Please look at the [star_rating-liquid_filter README](https://github.com/LawrenceWoodman/star_rating-liquid_filter/blob/master/README.md) for the latest instructions._
1. Download the latest version of the plugin from the [star_rating-liquid_filter](https://github.com/LawrenceWoodman/star_rating-liquid_filter) repository
2. Copy `star_rating.filter.rb` to your `_plugins` directory
3. Copy the contents of `images` to your `images` directory

<h2>Using the Filter</h2>
If you had a variable such as `page.rating` then you could put `{{ "{{" }} page.rating|star_rating }}` in your text
and the relevant number of images would be displayed.

<h2>Final Thoughts</h2>
This filter will continue to be updated so please go to see it's github [repo](https://github.com/LawrenceWoodman/star_rating-liquid_filter) for the latest version.  I was pleased with how quick and easy it was to write plugins for Jekyll and it has given me ideas for all sorts of plugins which could aid my Jekyll use.  While writing the plugin, I had to skim a few Ruby tutorials to start learning the language.  During this I fell in love with the beauty and elegance of Ruby and intend to learn it properly very shortly.  For the type of work that I do, I can see how it will give me a good productivity boost and from what I have seen so far, even make programming more fun.
