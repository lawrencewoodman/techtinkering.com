---
layout: article
title: "Pisceans and October Babies More Likely to Become Poets.  Scraping Wikipedia Reveals All"
tags:
  - Web Scraping
  - Ruby
  - JavaScript
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

This is the second in a series of articles looking into whether when you were born affects your future.  In the previous article I looked at [Nobel laureates](http://techtinkering.com/2011/08/24/does-when-you-were-born-affect-your-chance-of-becoming-a-nobel-laureate), which are, of course, from a range of fields.  Now it is time to focus on just one discipline with poets.  I have again used [ScraperWiki](http://scraperwiki.com) to scrape [wikipedia](http://wikipedia.org).  This time using its [list of poets](http://en.wikipedia.org/wiki/List_of_poets) and extracting each person's _Date of Birth_.

## The Findings

The dates of birth were collated and from this frequency charts were constructed for the months of birth and star signs of the poets.  The findings are illustrated below.

### Distribution of Months of Birth Among Poets
<img src="/images/posts/poets_mob.png" title="Distribution of Months of Birth Among Poets"/>

There is not too much difference here between the months, although October and June do stand out as having more poets or less poets respectively.  The difference between October and June is `2.99%`.  This is interesting as the result for poets born in June is the inverse of the result for Nobel laureates born in June, where they were most likely to become a Nobel laureate.

<table class="neatTable" style="clear: left;"> 
  <tr><th>Month of Birth</th><th>Frequency</th><th>Percent</th></tr> 
  <tr><td>January</td><td>44</td><td>8.21</td></tr> 
  <tr><td>February</td><td>46</td><td>8.58</td></tr> 
  <tr><td>March</td><td>49</td><td>9.14</td></tr> 
  <tr><td>April</td><td>40</td><td>7.46</td></tr> 
  <tr><td>May</td><td>42</td><td>7.84</td></tr> 
  <tr><td>June</td><td>37</td><td>6.90</td></tr> 
  <tr><td>July</td><td>47</td><td>8.77</td></tr> 
  <tr><td>August</td><td>46</td><td>8.58</td></tr> 
  <tr><td>September</td><td>45</td><td>8.40</td></tr> 
  <tr><td>October</td><td>53</td><td>9.89</td></tr> 
  <tr><td>November</td><td>44</td><td>8.21</td></tr> 
  <tr><td>December</td><td>43</td><td>8.02</td></tr> 
</table> 

**Sample Size:** 536

### Distribution of Star Signs Among Poets
<img src="/images/posts/poets_star_sign.png" title="Distribution of Star Signs Among Poets"/>

As with Nobel laureates the difference in distribution of star signs among poets seems to be much greater then the distribution of the months in which they were born.  We can see from the graph that Pisceans are more likely to be poets than Geminis and Taureans.  However, if you look more closely at Pisces at the top and Gemini at the bottom, you will find that while the difference is `2.8%`, this is actually less than the difference between highest and lowest for months of birth.

<table class="neatTable" style="clear: left;"> 
  <tr><th>Star Sign</th><th>Frequency</th><th>Percent</th><th>Dates</th></tr>
  <tr><td>Aries</td><td>44</td><td>8.21</td><td>21 March - 19 April</td></tr> 
  <tr><td>Taurus</td><td>39</td><td>7.28</td><td>20 April - 20 May</td></tr> 
  <tr><td>Gemini</td><td>38</td><td>7.09</td><td>21 May - 20 June</td></tr> 
  <tr><td>Cancer</td><td>44</td><td>8.21</td><td>21 June - 22 July</td></tr> 
  <tr><td>Leo</td><td>47</td><td>8.77</td><td>23 July - 22 August</td></tr> 
  <tr><td>Virgo</td><td>51</td><td>9.51</td><td>23 August - 22 September</td></tr> 
  <tr><td>Libra</td><td>49</td><td>9.14</td><td>23 September - 22 October</td></tr> 
  <tr><td>Scorpio</td><td>43</td><td>8.02</td><td>23 October - 21 November</td></tr> 
  <tr><td>Sagittarius</td><td>44</td><td>8.21</td><td>22 November - 21 December</td></tr> 
  <tr><td>Capricorn</td><td>42</td><td>7.84</td><td>22 December - 19 January</td></tr> 
  <tr><td>Aquarius</td><td>42</td><td>7.84</td><td>20 January - 18 February</td></tr> 
  <tr><td>Pisces</td><td>53</td><td>9.89</td><td>19 February - 20 March</td></tr> 
</table> 

**Sample Size:** 536

## Problems With The Study
The problems with this study are similar to those for the article about
Nobel laureates.

* The distribution of months of birth and star signs could just represent the normal
  distribution for that population and therefore should be compared to non
  prize winners.
* Quite a few of the poets didn't have an accurate date of birth, and were therefore
  excluded.
* The sample size is relatively small.

## Conclusion
Unlike Nobel laureates the distribution of birth periods among poets seems to be about the same for star signs and months of birth.  It seems that if your are a Piscean or born in October then you are more likely to be a poet and if you are a Gemini or born in June then you are less likely.

## Commissions
This series highlights the power of scraping the web to extract these sort of statistics and given the time, this could be extended to increase confidence in the data and draw more accurate conclusions.  If you would like to commission, [vLife Systems](http://vlifesystems.com), to create a scraper which will extract data from websites or other data sources of interest to you, please get in touch via email: <info@vlifesystems.com>.

## Other Articles in the Series
* [Does When You Were Born Affect Your Chance of Becoming a Nobel Laureate? Scraping Wikipedia to Find Out](http://techtinkering.com/2011/08/24/does-when-you-were-born-affect-your-chance-of-becoming-a-nobel-laureate)

---

## Scrapers and Views
I have given examples of the code used to scrape Wikipedia in the previous article.  For this article I will just reference the scrapers and provide code for one of the views instead.

* [Poets' Names and Wiki URLS Scraper](https://scraperwiki.com/scrapers/poets_names_and_wiki_urls/)
* [Poets' DOB Scraper](https://scraperwiki.com/scrapers/poets_dob/)
* [Poets' Month of Birth View](https://scraperwiki.com/views/poets_mob/)
* [Poets' Star Signs View](https://scraperwiki.com/views/poets_star_signs/)

### Poets' Month of Birth View
The view is again written in Ruby and has html and JavaScript embedded within an erb template.  The JavaScript is being used to create a graph with [Google Charts](http://code.google.com/apis/chart/).

{% highlight ruby %}
require 'date'
require 'erb'
sourcescraper = 'https://scraperwiki.com/scrapers/poets_dob/'

class PopulationStats

  attr_reader :frequency, :percent, :population_size
  def initialize(population, field)
    @population = population
    @frequency = calc_frequency(field)
    @population_size = calc_population_size
    @percent = calc_percent

  end

  def calc_frequency(field)
    frequency = Hash.new(0)
    @population.each do |person|
      begin
        mob = Date::MONTHNAMES[Date.parse(person[field]).month]
        frequency[mob] += 1
      rescue
      end
    end
    frequency
  end

  def calc_percent
    percent = {}
    @frequency.each do |variable, freq|
      percent[variable] = 1.0 * freq / @population_size * 100
    end
    percent
  end

  def calc_population_size
    population_size = 0
    @frequency.each {|term, freq| population_size += freq}
    population_size
  end

end

MONTH_NAMES = Date::MONTHNAMES[1..12]

def sort_stats(stats)
  MONTH_NAMES.collect do |month|
    [month, stats[month]]    
  end
end


PAGE_TEMPLATE = "
  <!--Load the AJAX API-->
  <script type='text/javascript' src='https://www.google.com/jsapi'></script>
  <script type='text/javascript'>
  
    // Load the Visualization API and the piechart package.
    google.load('visualization', '1.0', {'packages':['corechart']});
    
    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawChart);
    
    // Callback that creates and populates a data table, 
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawChart() {

      // Create the data table.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Month');
      data.addColumn('number', 'Percentage');
      data.addRows([
% population_percent.each do |stat|
        ['<%= stat[0].capitalize %>', <%= stat[1] %>],
% end
      ]);

      // Set chart options
      var options = {'title':'Months of Birth for Poets',
                     'width':650,
                     'height':500};


      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    }
  </script>

  <h2>The Distribution of Months of Birth Among Notable Poets</h2>

  <div>
    This was obtained by scraping wikipedia&#039;s 
    <a href='http://en.wikipedia.org/wiki/List_of_poets'>List of poets</a>.
    Then the page of each person listed was scraped to see when they were born.
  </div>

  <!--Div that will hold the pie chart-->
  <div id='chart_div'></div>

  <table>
    <tr>
      <th style='text-align: left;'>Month of Birth</th>
      <th style='text-align: left; padding-right: 1em;'>Frequency</th>
      <th style='text-align: left; padding-right: 1em;'>Percent</th>
    </tr>
% term_index = 0
% population_freq.each do |stat|
    <tr>
      <td style='padding-right: 1em;'><%= stat[0].capitalize %></td>
      <td><%= stat[1] %></td>
      <td><%= sprintf('%.2f', population_percent[term_index][1]) %></td>
    </tr>
%   term_index += 1
% end
  </table>

  <div style='padding-top: 1em;'>
    <strong>Sample Size:</strong> <%= population_size %>
  </div>
"

ScraperWiki.attach("poets_dob") 

data = ScraperWiki.select(           
  "dob from poets_dob.swdata"
)

popStats = PopulationStats.new(data, 'dob')
population_freq = sort_stats(popStats.frequency)
population_percent = sort_stats(popStats.percent)
population_size = popStats.population_size

puts ERB.new(PAGE_TEMPLATE, 0, '%').result(binding)
{% endhighlight %}
