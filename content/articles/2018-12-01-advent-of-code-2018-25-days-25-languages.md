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

For [day 2](https://adventofcode.com/2018/day/2) I have chosen [ruby](https://www.ruby-lang.org).  I used to use ruby quite a lot at one time, but was surprised how much I had forgotten.  The code is probably not very idiomatic, but it wasn't too hard to convert the Tcl solution over to ruby.

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
## Day 3: No Matter How You Slice It

For [day 3](https://adventofcode.com/2018/day/3) I have chosen [c](https://en.wikipedia.org/wiki/C_(programming_language)).  This is a language that I've used longer than any other, but haven't touched for over 3 years, so was a bit rusty.  It was quite enjoyable getting back in the saddle after so long.  For the solution to the puzzle I have made it do just enough to solve the problem and therefore it uses static arrays and isn't very dynamic.

```` c
// Code for Day 3 of Advent of Code: https://adventofcode.com/2018/day/3
// C Solution
//
// Copyright (C) 2018 Lawrence Woodman <lwoodman@vlifesystems.com>
// Licensed under an MIT licence.  Please see LICENCE.md for details.

#include <stdio.h>
#include <stdlib.h>

#define BITMAPMAXX 1500
#define BITMAPMAXY 1500
#define CLAIMSIZE 100
#define MAXCLASHIDS 2000

int part1 () {
  int count;
  int x, y, maxX, maxY;
  int id, leftMargin, topMargin, width, height;
  char bitmap[BITMAPMAXY][BITMAPMAXX];
  FILE *fp;
  static char claim[CLAIMSIZE];

  for (x = 0; x < BITMAPMAXX; x++) {
    for (y = 0; y < BITMAPMAXY; y++) {
      bitmap[y][x] = 0;
    }
  }

  if ((fp = fopen("day3.input", "r")) == NULL) {
		exit(EXIT_FAILURE);
  }
  while (fgets(claim, CLAIMSIZE, fp)) {
    sscanf(claim, "#%d @ %d,%d: %dx%d",
         &id, &leftMargin, &topMargin, &width, &height);
    maxX = leftMargin + width;
    maxY = topMargin + height;
    if (maxX >= BITMAPMAXX || maxY >= BITMAPMAXY) {
      fprintf(stderr, "bitmap too small\n");
      exit(EXIT_FAILURE);
    }
    for (x = leftMargin + 1; x <= maxX; x++) {
      for (y = topMargin + 1; y <= maxY; y++) {
        bitmap[y][x]++;
      }
    }
  }

  fclose(fp);

  count = 0;
  for (x = 0; x < BITMAPMAXX; x++) {
    for (y = 0; y < BITMAPMAXY; y++) {
      if (bitmap[y][x] >= 2) {
        count++;
      }
    }
  }
  return count;
}

int part2 () {
  int clashIDS[MAXCLASHIDS];
  int maxID = 0;
  int x, y, maxX, maxY;
  int id, leftMargin, topMargin, width, height;
  short bitmap[BITMAPMAXY][BITMAPMAXX];
  FILE *fp;
  static char claim[CLAIMSIZE];

  for (x = 0; x < BITMAPMAXX; x++) {
    for (y = 0; y < BITMAPMAXY; y++) {
      bitmap[y][x] = 0;
    }
  }
  if ((fp = fopen("day3.input", "r")) == NULL) {
    fprintf(stderr, "Couldn't open input\n");
		exit(EXIT_FAILURE);
  }
  while (fgets(claim, CLAIMSIZE, fp)) {
    sscanf(claim, "#%d @ %d,%d: %dx%d",
         &id, &leftMargin, &topMargin, &width, &height);
    maxX = leftMargin + width;
    maxY = topMargin + height;
    if (id >= MAXCLASHIDS) {
      fprintf(stderr, "clashIDS too small\n");
      exit(EXIT_FAILURE);
    }
    for (x = leftMargin + 1; x <= maxX; x++) {
      for (y = topMargin + 1; y <= maxY; y++) {
        if (bitmap[y][x] >= 1) {
          clashIDS[id] = 1;
          maxID = id > maxID ? id : maxID;
          clashIDS[bitmap[y][x]] = 1;
        } else {
          bitmap[y][x] = id;
        }
      }
    }
  }

  fclose(fp);

  for (id = 1; id <= maxID; id++) {
    if (clashIDS[id] == 0) {
      return id;
    }
  }
  return -1;
}

void main(void) {
  printf("part1: %d\n", part1());
  printf("part2: %d\n", part2());
}
````

## Day 4: Repose Record
For [day 4](https://adventofcode.com/2018/day/4) I have chosen [python](https://www.python.org/).  This is one of the most popular programming languages and yet I have never written anything in it before today.  This made it quite interesting as I have heard lots of good things about the language and it was great to give it a go.  Apologies to any Python programmers for my naturally poor style.

```` python
# Code for Day 4 of Advent of Code: https://adventofcode.com/2018/day/4
# Python Solution
#
# Copyright (C) 2018 Lawrence Woodman <lwoodman@vlifesystems.com>
# Licensed under an MIT licence.  Please see LICENCE.md for details.

import re
from datetime import datetime, date, time

input = open('day4.input').readlines()

def getDate(e):
    stampRE = re.compile("^.*(\d\d\d\d-\d\d-\d\d \d\d:\d\d).*$")
    stamp = stampRE.findall(e)[0]
    return datetime.strptime(stamp, "%Y-%m-%d %H:%M").timestamp()

def part1(input):
    pattern = {}
    input.sort(key=getDate)

    guardRE = re.compile("^.*\d\d\d\d-\d\d-\d\d \d\d:\d\d.*Guard #(\d+).*$")
    sleepRE = re.compile("^.*\d\d\d\d-\d\d-\d\d \d\d:(\d\d).*falls.*$")
    wakeRE = re.compile("^.*\d\d\d\d-\d\d-\d\d \d\d:(\d\d).*wake.*$")
    for entry in input:
        if guardRE.match(entry):
            guardID = guardRE.findall(entry)[0]
        elif sleepRE.match(entry):
            sleep = int(sleepRE.findall(entry)[0])
        elif wakeRE.match(entry):
            wake = int(wakeRE.findall(entry)[0])
            for m in range(sleep, wake):
                num = 1
                if guardID not in pattern:
                    pattern[guardID] = {}
                if m in pattern[guardID]:
                    num = pattern[guardID][m]
                    num += 1
                pattern[guardID][m] = num

    sleepiestID = -1
    sleepiestMinutes  = -1
    for id, sleep in pattern.items():
        totalSleep = 0
        for m, num in sleep.items():
            totalSleep += num
        if totalSleep > sleepiestMinutes:
            sleepiestMinutes = totalSleep
            sleepiestID = id

    sleepiestMin = -1
    sleepiestNum = -1
    for m, num in pattern[sleepiestID].items():
        if num > sleepiestNum:
            sleepiestNum = num
            sleepiestMin = m

    return(int(sleepiestID) * int(sleepiestMin))

def part2(input):
    pattern = {}
    input.sort(key=getDate)

    guardRE = re.compile("^.*\d\d\d\d-\d\d-\d\d \d\d:\d\d.*Guard #(\d+).*$")
    sleepRE = re.compile("^.*\d\d\d\d-\d\d-\d\d \d\d:(\d\d).*falls.*$")
    wakeRE = re.compile("^.*\d\d\d\d-\d\d-\d\d \d\d:(\d\d).*wake.*$")
    for entry in input:
        if guardRE.match(entry):
            guardID = guardRE.findall(entry)[0]
        elif sleepRE.match(entry):
            sleep = int(sleepRE.findall(entry)[0])
        elif wakeRE.match(entry):
            wake = int(wakeRE.findall(entry)[0])
            for m in range(sleep, wake):
                num = 1
                if guardID not in pattern:
                    pattern[guardID] = {}
                if m in pattern[guardID]:
                    num = pattern[guardID][m]
                    num += 1
                pattern[guardID][m] = num

    sleepiestID = -1
    sleepiestMinutes  = -1
    for id, sleep in pattern.items():
        totalSleep = 0
        for m, num in sleep.items():
            totalSleep += num
        if totalSleep > sleepiestMinutes:
            sleepiestMinutes = totalSleep
            sleepiestID = id

    sleepiestID = -1
    sleepiestMin = -1
    sleepiestNum = -1
    for id, sleep in pattern.items():
        for m, num in sleep.items():
            if num > sleepiestNum:
                sleepiestNum = num
                sleepiestMin = m
                sleepiestID = id

    return(int(sleepiestID) * int(sleepiestMin))


print("Part1: ", part1(input))
print("Part2: ", part2(input))
````

## Day 5: Alchemical Reduction
For [day 5](https://adventofcode.com/2018/day/5) I have chosen [racket](https://racket-lang.org/).  I haven't written much in racket and what I have was quite a few years ago.  To start with I quite liked using the DrRacket environment and REPL, but after a while I was struggling to get my head into the mindset required for racket.  I managed to do a recursive solution, but it is pretty ugly and slow.

```` scheme
#lang racket/base
; Code for Day 5 of Advent of Code: https://adventofcode.com/2018/day/5
; Racket Solution
;
; Copyright (C) 2018 Lawrence Woodman <lwoodman@vlifesystems.com>
; Licensed under an MIT licence.  Please see LICENCE.md for details.

(require racket/file
         racket/list
         racket/math
         racket/string)

(define (opposite-case? a b)
  (and (not (equal? a b)) (equal? (string-upcase a) (string-upcase b))))

(define input
  (map string (string->list (string-trim (file->string "day5.input")))))


(define (react input start)
  (if (>= start (- (length input) 1))
      input
      (let ([trial (list-tail input start)])
        (let ([a (first trial)]
              [b (second trial)])
          (if (opposite-case? a b)
              (react (append (take input start)
                             (list-tail input (+ start 2)))
                     start)
              (react input (+ start 1)))))))


(define (chainreaction input)
  (let ([new-input (react input 0)])
    (if (= (length input) (length new-input))
        input
        (chainreaction new-input))))

(define (part1 input)
  (length (chainreaction input)))

(define (part2 input)
  (second
   (let* ([letters '("a" "b" "c" "d" "e" "f" "g" "h"
                            "i" "j" "k" "l" "m" "n" "o" "p"
                            "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")]
          [lens (map (lambda (l)
                       (let ([new-input
                            (filter (lambda (e)
                                      (not (equal? (string-downcase l)
                                                   (string-downcase e))))
                                    input)])
                         (list l (part1 new-input))))
                     letters)])
          (for/fold ([shortest (list "!" (length input))])
                    ([l lens])
            (if (< (second l) (second shortest))
                l
                shortest)))))


(printf "Part1: ~a\n" (part1 input))
(printf "Part2: ~a\n" (part2 input))
````
