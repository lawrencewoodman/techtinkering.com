---
layout: article
title: "Improving the related_posts feature of jekyll"
tags:
  - Jekyll
  - Ruby
  - Web Development
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
Now that I have converted TechTinkering over to [Jekyll](http://jekyllrb.com/), I have come up against a bit of a problem with `site.related_posts`: The results are always just the latest posts, and are not filtered or ordered for relevance.  I see that lots of people are struggling with a similar problem and have therefore decided to write a plugin which will improve it.  Because the posts on this site make use of _tags_, I decided to match against those to assess relevance.

## The Code
I was in two minds as to how to structure this plugin: whether to write a straight monkey patch, or whether to put it in a module and include it.  I went with the latter as I have heard a lot of talk about this being the preferred route to ease debugging.  However it doesn't seem quite right because I have had to force the removal of the old `related_posts` method to do so.  If anyone has any suggestions on this, then please leave a comment here or via the [GitHub repo](https://github.com/LawrenceWoodman/related_posts-jekyll_plugin).

At the time of writing, the `related_posts.rb` plugin file looks like this:
{% highlight ruby %}
require 'jekyll/post'

module RelatedPosts

  # Used to remove #related_posts so that it can be overridden
  def self.included(klass)
    klass.class_eval do
      remove_method :related_posts
    end
  end

  # Calculate related posts.
  #
  # Returns [<Post>]
  def related_posts(posts)
    return [] unless posts.size > 1
    highest_freq = Jekyll::Post.tag_freq(posts).values.max
    related_scores = Hash.new(0)
    posts.each do |post|
      post.tags.each do |tag|
        if self.tags.include?(tag) && post != self
          cat_freq = Jekyll::Post.tag_freq(posts)[tag]
          related_scores[post] += (1+highest_freq-cat_freq)
        end
      end
    end

    Jekyll::Post.sort_related_posts(related_scores)
  end

  module ClassMethods
    # Calculate the frequency of each tag.
    #
    # Returns {tag => freq, tag => freq, ...}
    def tag_freq(posts)
      return @tag_freq if @tag_freq
      @tag_freq = Hash.new(0)
      posts.each do |post|
        post.tags.each {|tag| @tag_freq[tag] += 1}
      end
      @tag_freq
    end

    # Sort the related posts in order of their score and date
    # and return just the posts
    def sort_related_posts(related_scores)
      related_scores.sort do |a,b|
        if a[1] < b[1]
          1
        elsif a[1] > b[1]
          -1
        else
          b[0].date <=> a[0].date
        end
      end.collect {|post,freq| post}
    end
  end

end

module Jekyll
  class Post
    include RelatedPosts
    extend RelatedPosts::ClassMethods
  end
end
{% endhighlight %}

## Installation
_Please look at the [README](https://github.com/LawrenceWoodman/related_posts-jekyll_plugin/blob/master/README.rdoc) file for the latest instructions._
1. Download the latest version of the plugin from the [related_posts-jekyll_plugin](https://github.com/LawrenceWoodman/related_posts-jekyll_plugin) repository
2. Copy `related_posts.rb` to your `_plugins` directory

## Using `site.related_posts`
The plugin replaces the functionality of `site.related_posts` so you
can use it as follows:
{% highlight html %}
{{ "{" }}% for post in site.related_posts %}
  <a href="{{ "{{" }} post.url }}">{{ "{{" }}post.title }}</a><br />
{{ "{" }}% endfor %}
{% endhighlight %}
