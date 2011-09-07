require 'jekyll'

module Jekyll
  module Filters

    # Format a date in long format e.g. "7 January 2011".
    #
    # Monkey patched to use blank padding for the day of the month
    # instead of zero padding.
    #
    # date - The Time to format.
    #
    # Returns the formatted String.
    def date_to_long_string(date)
      date.strftime("%e %B %Y")
    end
  end
end

