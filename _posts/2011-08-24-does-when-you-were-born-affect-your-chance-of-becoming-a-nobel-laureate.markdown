---
layout: article
title: "Does When You Were Born Affect Your Chance of Becoming a Nobel Laureate? Scraping Wikipedia to Find Out"
tags:
  - Web Scraping
  - Ruby
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

There has been a lot of talk in the UK recently about whether when you were born affects your schooling.  Lots of teachers have noticed how pupils born at the end of the Summer often struggle compared with those born in the Autumn, which makes sense because the latter group are almost a year older when they start school than the former.  However, teachers are not the only ones who think that when you were born affects your future.  Astrologers base much of what they do on when a person was born.

To see if when you were born does affect your future, I have decided to look at various groups over a series of articles.  For this, the first article, I am beginning with Nobel laureates, as they come from many different countries, represent excellence in their field and they are reasonably well documented on [wikipedia](http://wikipedia.org).  The data for the study was collected by using [ScraperWiki](http://scraperwiki.com) to build a series of scrapers and views to go through the [List of Nobel laureates](http://en.wikipedia.org/wiki/List_of_nobel_prize_winners) and find the _Date of Birth_ for each person.

## The Findings

The dates of birth were collated and from this frequency charts were constructed for the months of birth and star signs of the Nobel laureates.  The findings are illustrated below.

### Distribution of Months of Birth Among Nobel Prize Winners
<img src="/images/posts/nobel_laureates_mob.png" title="Distribution of Months of Birth Among Nobel Laureates"/>

There is not too much difference here between the months, although June does stand out as having significantly more Nobel laureates than other months, and in fact is `3.75%` ahead of the lowest month, January.

February is interesting because it would be expected to be a bit lower since it has less days.  If you look at February's lowest number of days compared to the highest number of days in other months you will see that it can have as little as `90%` of the days (`28/31 = 0.9032`).  This is enough to account for its low percentage as if you take March with 31 days and take `90%` of its figure you would get `7.74%` (`8.57*0.9032`), which is a little low, but not markedly so.

<table class="neatTable" style="clear: left;">
  <tr><th>Month of Birth</th><th>Frequency</th><th>Percent</th></tr>
  <tr><td>January</td><td>50</td><td>6.69</td></tr>
  <tr><td>February</td><td>44</td><td>5.89</td></tr>
  <tr><td>March</td><td>64</td><td>8.57</td></tr>
  <tr><td>April</td><td>57</td><td>7.63</td></tr>
  <tr><td>May</td><td>63</td><td>8.43</td></tr>
  <tr><td>June</td><td>78</td><td>10.44</td></tr>
  <tr><td>July</td><td>64</td><td>8.57</td></tr>
  <tr><td>August</td><td>68</td><td>9.10</td></tr>
  <tr><td>September</td><td>66</td><td>8.84</td></tr>
  <tr><td>October</td><td>69</td><td>9.24</td></tr>
  <tr><td>November</td><td>60</td><td>8.03</td></tr>
  <tr><td>December</td><td>64</td><td>8.57</td></tr>
</table>

**Sample Size:** 747

### Distribution of Star Signs Among Nobel Prize Winners
<img src="/images/posts/nobel_laureates_star_sign.png" title="Distribution of Star Signs Among Nobel Laureates"/>

The difference in the distribution of star signs among Nobel laureates seems to be much greater then the distribution of the months in which they were born.  It is quite clear here that Gemini and Libra stand out from the others, particularly when compared to Capricorn and Aquarius where the greatest difference is `5.09%`.

<table class="neatTable" style="clear: left;">
  <tr><th>Star Sign</th><th>Frequency</th><th>Percent</th><th>Dates</th></tr>
  <tr><td>Aries</td><td>64</td><td>8.57</td><td class="note">21 March - 19 April</td></tr>
  <tr><td>Taurus</td><td>61</td><td>8.17</td><td class="note">20 April - 20 May</td></tr>
  <tr><td>Gemini</td><td>78</td><td>10.44</td><td class="note">21 May - 20 June</td></tr>
  <tr><td>Cancer</td><td>72</td><td>9.64</td><td class="note">21 June - 22 July</td></tr>
  <tr><td>Leo</td><td>54</td><td>7.23</td><td class="note">23 July - 22 August</td></tr>
  <tr><td>Virgo</td><td>72</td><td>9.64</td><td class="note">23 August - 22 September</td></tr>
  <tr><td>Libra</td><td>80</td><td>10.71</td><td class="note">23 September - 22 October</td></tr>
  <tr><td>Scorpio</td><td>56</td><td>7.50</td><td class="note">23 October - 21 November</td></tr>
  <tr><td>Sagittarius</td><td>60</td><td>8.03</td><td class="note">22 November - 21 December</td></tr>
  <tr><td>Capricorn</td><td>42</td><td>5.62</td><td class="note">22 December - 19 January</td></tr>
  <tr><td>Aquarius</td><td>47</td><td>6.29</td><td class="note">20 January - 18 February</td></tr>
  <tr><td>Pisces</td><td>56</td><td>7.50</td><td class="note">19 February - 20 March</td></tr>
</table>

**Sample Size:** 747

## Problems With The Study
* The distribution of months of birth and star signs could just represent the normal
  distribution for that population and therefore should be compared to non
  prize winners.
* The list is dominated by Europeans. Therefore there will be some similar
  conditions, such as weather patterns, although school terms will be
  different where relevant.
* A few of the laureates didn't have an accurate date of birth, and were therefore
  excluded.
* The sample size is relatively small.


## Conclusion
There does seem to be some variance between the birth periods and interestingly this seems to be more pronounced for star signs than for months of birth.  In particular, Geminis and Libras or people born in June do stand out as being more likely to receive a Nobel prize, whereas Capricorns and Aquariuses or people born in January or February are less likely to receive a Nobel Prize.


## Commissions
This study highlights the power of scraping the web to extract these sort of statistics and given the time, this could be extended to increase confidence in the data and draw more accurate conclusions.  If you would like to commission, [vLife Systems](http://vlifesystems.com), to create a scraper which will extract data from websites or other data sources of interest to you, please get in touch via email: <info@vlifesystems.com>.

## Other Articles in the Series
* [Pisceans and October Babies More Likely to Become Poets. Scraping Wikipedia Reveals All](http://techtinkering.com/2011/09/08/pisceans-and-october-babies-more-likely-to-become-poets/)
---

## Scrapers and Views
For those interested, links to the views and the code for the scrapers is listed below.
The code is current at the time of writing, but may have changed since,
so please go to the original source to see the latest versions.

### Nobel Prize Winners Names and Wiki Urls
This was the first stage.  The scraper was used to compile a database of Nobel laureates and links to their pages on Wikipedia.  The original scraper is to be found on ScraperWiki: [Nobel Prize Winners Names and Wiki Urls](https://scraperwiki.com/scrapers/nobel_prize_winners_names_and_wiki_urls/)

{% highlight ruby %}
require 'nokogiri' 

html = ScraperWiki.scrape("http://en.wikipedia.org/wiki/Nobel_prize_winners")

winners = {}
doc = Nokogiri::HTML(html)
doc.css('table.wikitable td span.fn a').each do |a|
  name = a.inner_text
  wiki_url = a.attribute('href')
  absolute_url = "http://wikipedia.org#{wiki_url}"
  winners[absolute_url] = name
end

# Save data to database
winners.each do |url, name|
  data = {
    'url' => url,
    'name' => name
  }
  ScraperWiki.save_sqlite(unique_keys=['url'], data=data)
end
{% endhighlight %}

### Nobel Prize Winners' DOB
The next stage was to scrape the Wikipedia page of each person and get their Date of Birth.  The original scraper is to be found on ScraperWiki: [Nobel Prize Winners' DOB](https://scraperwiki.com/scrapers/nobel_prize_winners_dob/)

{% highlight ruby %}
require 'date'
require 'nokogiri'

module StarSign
  # Dates from: http://my.horoscope.com/astrology/horoscope-sign-index.html
  STAR_SIGN_DATES = {
    'aries' =>       ['21 March 2011', '19 April 2011'],
    'taurus' =>      ['20 April 2011', '20 May 2011'],
    'gemini' =>      ['21 May 2011', '20 June 2011'],
    'cancer' =>      ['21 June 2011', '22 July 2011'],
    'leo' =>         ['23 July 2011', '22 August 2011'],
    'virgo' =>       ['23 August 2011', '22 September 2011'],
    'libra' =>       ['23 September 2011', '22 October 2011'],
    'scorpio' =>     ['23 October 2011', '21 November 2011'],
    'sagittarius' => ['22 November 2011', '21 December 2011'],
    'capricorn' =>   ['22 December 2011', '19 January 2012'],
    'aquarius' =>    ['20 January 2011', '18 February 2011'],
    'pisces' =>      ['19 February 2011', '20 March 2011']
  }

  def star_sign
    compare_date = Date.parse(self.to_s.sub(/^\d+-/, "2011-"))
    STAR_SIGN_DATES.each do |sign, dates|
      if compare_date >= Date.parse(dates[0]) &&
         compare_date <= Date.parse(dates[1])
        return sign
      end
    end
    # FIX:  It has to be capricorn here, the problem is due to the years
    return 'capricorn'
  end
end

class Date
  include StarSign
end

class DOBScraper
  attr_reader :population

  def initialize(dob_database)
    ScraperWiki.attach(dob_database) 
    @population = prize_winners = ScraperWiki.select(           
      "name, url from nobel_prize_winners_names_and_wiki_urls.swdata 
       order by name"
    )
    @last_saved_name = ScraperWiki.get_var('last_saved_name') 
  end

  def dump_dob(name, dob, star_sign)
    data = {
      'name' => name,
      'dob' => dob,
      'star_sign' => star_sign
    }

    ScraperWiki.save_sqlite(unique_keys=['name'], data=data)
    ScraperWiki.save_var('last_saved_name', name)
    @last_saved_name = name
  end

  def extract_dob(person)
    name,url = person['name'], person['url']
    begin
      html = ScraperWiki.scrape(url)
    rescue StandardError => error
      puts "Error: #{error} (url: #{url})"
    end

    doc = Nokogiri::HTML(html)
    doc.css('table.infobox th').each do |th|
      if th.inner_text == "Born"
        born = th.parent.at('td').inner_text
        dob = born.scan(/.*?1[6789]\d\d/).first
        begin
          star_sign = Date.parse(dob).star_sign
          dump_dob(name, dob, star_sign)
        rescue StandardError => error
          puts "Error: #{error} dob: #{dob} (name: #{name} url: #{url})"
        end
        
      end
    end
  
  end

  def skip_person?(name)
    return false unless @last_saved_name
    name_index = @population.find_index{|winner| winner['name'] == name}
    last_saved_index = @population.find_index{|winner| winner['name'] == @last_saved_name}
    last_saved_index >= name_index && last_saved_index != @population.size-1
  end

  def scrape
    @population.each do |person|
      unless skip_person?(person['name'])
        extract_dob(person)
      end
    end
  end
end

dob_scraper = DOBScraper.new('nobel_prize_winners_names_and_wiki_urls')
dob_scraper.scrape
{% endhighlight %}

### Nobel Prize Winners' Star Sign and Month of Birth Views

To visualise the results of the scraping I created a couple of views.  I have decided not to include the code for these here as they are quite long and would be better off linked to.  They can again be found on ScraperWiki: [Nobel Prize Winners MOB](https://scraperwiki.com/views/nobel_prize_winners_mob/) and [Nobel Prize Winners' Star Signs](https://scraperwiki.com/views/nobel_prize_winners_star_signs/)
