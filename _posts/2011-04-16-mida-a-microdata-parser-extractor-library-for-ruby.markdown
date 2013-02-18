---
layout: article
title: "Mida - A Microdata parser/extractor library for Ruby"
summaryPic: small_microdata.png
tags:
  - Microdata
  - Gem
  - Library
  - Ruby
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I have recently released [Mida](http://lawrencewoodman.github.com/mida/ "Mida Project Page") as a Gem for parsing/extracting [Microdata](http://en.wikipedia.org/wiki/Microdata_%28HTML5%29) from web pages.  Not many sites at the moment are using Microdata, in fact, apart from this site, I only know of one other: [Trust a Friend](http://trustafriend.com), which is another site that I work on.  However, as HTML5 is more widely adopted I am sure that this will change and Mida will become more useful.

## Microdata
Microdata is part of the upcoming HTML5 standard and is a way to label the
content on web pages so that it is machine readable.  I prefer this
to its main rival, Microformats, because it is simpler to implement, though
I do recognize that this can lead to its being more imprecise.

As an example, the following html is marked-up with Microdata:
{% highlight html %}
<div itemscope itemtype="http://data-vocabulary.org/Product"
     itemid="urn:isbn:1-86207-839-4">
  <h2 itemprop="name">Electronic Brains: Stories from the Dawn of the Computer Age</h2>
  By <span itemprop="brand">Mike Hally</span>
  <meta itemprop="category" content="Media > Books > Non-Fiction > Computer Books" />
  <meta itemprop="identifier" content="isbn:1-86207-839-4" />

  <div itemprop="review" itemscope itemtype="http://data-vocabulary.org/Review">
    <h3 itemprop="summary">Great short history of early computers</h3>
    Rated <span itemprop="rating">5.0</span>/5.0 by
    <span itemprop="reviewer">Lawrence Woodman</span> on
    <time itemprop="dtreviewed" datetime="2009-06-03">3rd March 2009</time>
    <div itemprop="description">
      While reading this I came across quite a few surprises, such as the early
      successes in Australia. There is also a chapter on Remington Rand's Rand
      409, another early computer which I don't think has been covered much elsewhere.
      Finally it tries to explain how IBM became the market leader despite its late entry
      into the field.
   </div>
  </div>
</div>
{% endhighlight %}

If the above were parsed it would yield the following information:
{% highlight yaml %}
{
  :type => "http://data-vocabulary.org/Product",
  :id => "urn:isbn:1-86207-839-4",
  :properties => {
    "name" => ["Electronic Brains: Stories from the Dawn of the Computer Age"],
    "brand" => ["Mike Hally"],
    "category" => ["Media > Books > Non-Fiction > Computer Books"],
    "identifier" => ["isbn:1-86207-839-4"],
    "review" => [{
      :type => "http://data-vocabulary.org/Review",
      :id => nil,
      :properties => {
        "summary" => ["Great short history of early computers"],
        "rating" => ["5.0"],
        "reviewer" => ["Lawrence Woodman"],
        "dtreviewed" => ["2009-06-03"],
        "description" => [
          "While reading this I came across quite a few surprises, such as the early
          successes in Australia. There is also a chapter on Remington Rand's Rand
          409, another early computer which I don't think has been covered much elsewhere.
          Finally it tries to explain how IBM became the market leader despite its late
          entry into the field."
        ]
      }
    }]
  }
}
{% endhighlight %}

## Installation
I have made a Gem for Mida and hosted it on [RubyGems](http://rubygems.org), so installation is as easy as:
{% highlight bash %}gem install mida{% endhighlight %}

## Usage
Mida is very easy to use as the following examples illustrate.  They all
assume that you have required `mida` and `open-uri`. 
This is the current usage and is likely to change, so please see the RDocs for
the current version.

### Extracting Microdata from a page

All the Microdata is extracted from a page when a new `Mida::Document` instance is created.

To extract all the Microdata from a webpage:
{% highlight ruby %}
url = 'http://example.com'
open(url) {|f| doc = Mida::Document.new(f, url)}
{% endhighlight %}

The top-level Items will be held in an `Array` accessible via `doc.items`.

To simply list all the top-level Items that have been found:
{% highlight ruby %}puts doc.items{% endhighlight %}

<h3>Searching</h3>

If you want to search for an Item that has a specific itemtype/vocabulary this
can be done with the `search` method.

To return all the Items that use one of Google’s Review vocabularies:
{% highlight ruby %}doc.search(%r{http://data-vocabulary\.org.*?review.*?}i){% endhighlight %}

<h3>Inspecting an Item</h3>

Each Item is a `Mida::Item` instance and has three main methods of interest, `type`, `properties` and `id`.

To find out the itemtype of the Item:
{% highlight ruby %}puts doc.items.first.type{% endhighlight %}

To find out the itemid of the Item:
{% highlight ruby %}puts doc.items.first.id{% endhighlight %}

Properties are returned as a `Hash` containing name/values pairs. The values will be an `Array` of either `String` or `Mida::Item` instances.

To see the properties of the Item:
{% highlight ruby %}puts doc.items.first.properties{% endhighlight %}


<h2>Contributing</h2>
Mida is still in the early stages and much is likely to change.  If you would like to contribute to the project, the source is hosted on [Github](https://github.com/LawrenceWoodman/mida "Mida's repository on GitHub").  The best place to raise ideas/bugs/feature requests is on [Mida's Issues](https://github.com/LawrenceWoodman/mida/issues) page.
