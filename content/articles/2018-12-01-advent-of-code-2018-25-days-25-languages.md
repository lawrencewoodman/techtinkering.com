There are lots of different programming challenges, but this year one in particular has caught my attention and I have decided to take part.  [Advent of Code](https://adventofcode.com) starts 1st December with daily programming puzzles throughout [advent](https://en.wikipedia.org/wiki/Advent).

To make this challenge a little more interesting I have decided to do the 25 puzzles in 25 different programming languages.  This will be interesting as while I have used quite a lot of different languages, I don't know 25 well.  I'm also have quite limited time in the run up to Christmas.  Therefore, I'm going to solve each puzzle first in Tcl and then create a second version in another language that gives the same result.  Tcl is one of my favourite languages so the code should be reasonably good.

I am putting my solutions in a [repo](https://github.com/lawrencewoodman/adventofcode) on GitHub.

## Day 1: Chronal Calibration

To ease myself in gradually the [day 1](https://adventofcode.com/2018/day/1) puzzle has been done with [Tcl](https://wiki.tcl-lang.org/) alone.

```` tcl
# Code for Day 1 of Advent of Code: https://adventofcode.com/2018/day/1
# Tcl Solution
set fp [open "day1.input" r]
set input [read $fp]
close $fp

proc part1 {input} {
  return [::tcl::mathop::+ {*}$input]
}

proc part2 {freqs startFreq input} {
  dict set freqs $startFreq 1
  set sum $startFreq
  foreach line $input {
    if {$line != ""} {
      set sum [expr {$sum + $line}]
      if {[dict exists $freqs $sum]} {
        return $sum
      } else {
        dict set freqs $sum 1
      }
    }
  }
  tailcall part2 $freqs $sum $input
}

puts "part1: [part1 $input]"
puts "part2: [part2 {} 0 $input]"
````

## Day 2: Inventory Management System

For [day2](https://adventofcode.com/2018/day/2) I have chosen [ruby](https://www.ruby-lang.org).  I used to use ruby quite a lot at one time, but was surprised how much I had forgotten.  The code is probably not very idiomatic, but it wasn't too hard to convert the Tcl solution over to ruby.

```` ruby
# Code for Day 2 of Advent of Code: https://adventofcode.com/2018/day/2
# Ruby Solution
input = File.read("day2.input")

def part1(input)
  numDuplicates = Hash.new(0)
  input.each_line do |id|
    numIncreased = Hash.new(0)
    freqs = Hash.new(0)
    id.each_char { |c| freqs[c] += 1 }
    freqs.each do |c, num|
      if !numIncreased.key?(num)
        numDuplicates[num] += 1
        numIncreased[num] = 1
      end
    end
  end
  numDuplicates[2] * numDuplicates[3]
end

def part2(input)
  input.each_line do |id1|
    input.each_line do |id2|
      numDiff = 0
      commonLetters = ""
      id1.each_char.with_index do |cid1, index|
        cid2 = id2[index]
        if cid1 == cid2
          commonLetters << cid1
        else
          numDiff += 1
        end
      end
      if numDiff == 1
        return commonLetters
      end
    end
  end
end

puts "Part1: #{part1(input)}"
puts "Part2: #{part2(input)}"
````
