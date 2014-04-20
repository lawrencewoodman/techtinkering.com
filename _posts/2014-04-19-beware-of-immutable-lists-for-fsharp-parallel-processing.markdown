---
layout: article
title: "Beware of Immutable Lists for F# Parallel Processing"
tags:
  - F#
  - Parallel Processing
  - Programming
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

With F#, the _list_ often feels like the default choice of data structure.  It is immutable and hence easy to reason about, however its use can come at a great cost.  If you are using lists to process large amounts of data, then a lot of time will be spent creating objects and garbage collecting.  When I stress tested lists with F#, it became clear that this can cause a major synchronization issue when parallel processing.  In fact, I was often seeing programs written in parallel which were effectively just context switching between threads rather than running in parallel.

# Investigating an Answer
I tried to find an answer to this problem and posted on stackoverflow: [How to execute a function, that creates a lot of objects, in parallel?](http://stackoverflow.com/questions/22778028/how-to-execute-a-function-that-creates-a-lot-of-objects-in-parallel).  This didn't lead to an answer, which left me with two options:

  1. Keep the immutable lists but use a serialization strategy to bring data in and out of a program that runs as a single processes.  Then use another program to distribute that data to each program and run them in parallel.
  2. Switch to mutable data structures to reduce the synchronization problems and time spent creating objects and garbage collecting.

My preference is for immutable data structures, however serializing data in and out can be slow depending on what is being processed and this ugly hack removed much of the beauty and transparency of using immutable data structures.  I therefore decided to investigate the effect of switching to mutable data structures to see what a difference this would make.  The difference was huge.

# An Example Program Using Immutable Lists
The script below (`program-noclass-list.fsx`) is a very basic data categorizer which relies on a field having a certain value as a rule to determine if this will predict a category.

{% highlight fsharp %}
// Filename: program-noclass-list.fsx
open System

type CategoryAssessment =
    { fieldIndex: int
      value: int
      ruleAssessments: list<int> }

let InitAssessment categorizeFields rules =
    let ruleAssessments = List.init (List.length rules) (fun x -> 0)
    List.map (fun categorizeField ->
                 let fieldIndex, categoryValue = categorizeField
                 { CategoryAssessment.fieldIndex = fieldIndex;
                   value = categoryValue;
                   ruleAssessments = ruleAssessments })
             categorizeFields

let AssessCategory ruleMatches (row : int[]) categoryAssessment =
    let fieldIndex = categoryAssessment.fieldIndex
    let categoryValue = categoryAssessment.value
    let categoryMatch = categoryValue = row.[fieldIndex]
    let newRuleAssessments =
        List.map2 (fun ruleAssessment ruleMatch ->
                       if ruleMatch = categoryMatch then
                           ruleAssessment + 1
                       else
                           ruleAssessment)
                  categoryAssessment.ruleAssessments
                  ruleMatches
    { categoryAssessment with ruleAssessments = newRuleAssessments }

let MatchRule (row : int[]) rule =
    let fieldIndex, eqVal = rule
    row.[fieldIndex] = eqVal

let Assess categorizeFields rules input =
  printfn "START - Assess"
  let d =
    Array.fold (fun categoryAssessment row ->
                 let ruleMatches = List.map (MatchRule row) rules
                 List.map (AssessCategory ruleMatches row) categoryAssessment)
               (InitAssessment categorizeFields rules)
               input
  printfn "END - Assess"
  d

let JoinAssessments assessments =
    let numAssessments = Array.length assessments
    Array.fold (fun accAssessment assessment ->
                    List.map2 (fun accCategory category ->
                                   let newRuleAssessments =
                                       List.map2 (+)
                                                 accCategory.ruleAssessments
                                                 category.ruleAssessments
                                   { accCategory with
                                         ruleAssessments = newRuleAssessments })
                              accAssessment
                              assessment)
               assessments.[0]
               assessments.[1..(numAssessments-1)]


let numRecords = 1000000
let numFields = 20
let numSplits = 10
let numRules = 10000
let inputs = Array.create numSplits
                          [| for i in 1 .. (numRecords / numSplits) ->
                                [| for j in 1 .. numFields ->
                                       (i % 10) + j |] |]
let categorizeFields = [ (1, 6); (2, 3); (2, 4); (3, 2) ]
let rules = [ for i in 1 .. numRules -> (i % numFields, i) ]

let assessments =
    Array.Parallel.map (Assess categorizeFields rules) inputs
    |> JoinAssessments
printfn "Assessments: %A" assessments
0
{% endhighlight %}

# Improvements
I made two main improvements, both involving moving to arrays.  The programs can be seen in full at the end of this article and the benchmarks in the next section.

<dl>
  <dt>program-no-class-array.fsx</dt>
  <dd>First I switched all the lists to arrays.  This would reduce the amount of memory allocation and garbage collection and hence synchronization issues.  Although arrays are mutable, I used them in an immutable way.</dd>

  <dt>program-no-class-mutable-array.fsx</dt>
  <dd>Secondly I made the record field for the arrays mutable and again reduced the time creating objects and garbage collecting.</dd>

  <dt>program-class-mutable-array.fsx</dt>
  <dd>The switch to mutable arrays made a big difference, but I wanted to regain some control of the mutability and hence created a <em>class</em> to improve access control.</dd>
</dl>

# Benchmarks
You can see below that the biggest difference was made by switching from lists to arrays and that still more could be done by moving to mutable arrays.

<table class="neatTable">
  <tr><th>Filename</th><th>User time</th><th>Elapsed time</th><th>CPU usage</th></tr>
  <tr><td>program-noclass-list.fsx</td><td>1568.44</td><td>23:11.65</td><td>115%</td></tr>
  <tr><td>program-noclass-array.fsx</td><td>83.09</td><td>0:59.14</td><td>142%</td></tr>
  <tr><td>program-class-mutable-array.fsx</td><td>60.57</td><td>0:35.64</td><td>172%</td></tr>
  <tr><td>program-noclass-mutable-array.fsx</td><td>55.82</td><td>0:33.19</td><td>172%</td></tr>
</table>


For those interested here are the benchmarks for the same programs run on a single thread (by changing the `numSplits` line to equal `1`).  This demonstrates the problem with `program-noclass-list.fsx` as it actually runs quicker with a single thread than it does in parallel.  It also shows the problem with lists in general where performance is an issue.

<table class="neatTable">
  <tr><th>Filename</th><th>User time</th><th>Elapsed time</th><th>CPU usage</th></tr>
  <tr><td>program-noclass-list.fsx</td><td>1154.09</td><td>20:02.16</td><td>99%</td></tr>
  <tr><td>program-noclass-array.fsx</td><td>81.99</td><td>1:23.42</td><td>99%</td></tr>
  <tr><td>program-class-mutable-array.fsx</td><td>61.73</td><td>1:06.60</td><td>94%</td></tr>
  <tr><td>program-noclass-mutable-array.fsx</td><td>51.83</td><td>0:52.87</td><td>100%</td></tr>
</table>

## Where Now?
It is important to pick the correct data structures for the job at hand.  As [Wirth](http://en.wikipedia.org/wiki/Niklaus_Wirth) said "Algorithms + Data Structures = Programs".  While <em>list</em>s are a great default data structure in F#, where performance is an issue it can be seen how important it is to look beyond this, particularly when using multiple threads.


------------------------------------------------

# Full Source Code for Programs

## program-noclass-array.fsx
{% highlight fsharp %}
// Filename: program-noclass-array.fsx
open System

type CategoryAssessment =
    { fieldIndex: int
      value: int
      ruleAssessments: int[] }

let InitAssessment categorizeFields rules =
    let ruleAssessments = Array.create (Array.length rules) 0
    Array.map (fun categorizeField ->
                   let fieldIndex, categoryValue = categorizeField
                   { CategoryAssessment.fieldIndex = fieldIndex;
                     value = categoryValue;
                     ruleAssessments = ruleAssessments })
              categorizeFields

let AssessCategory ruleMatches (row : int[]) categoryAssessment =
    let fieldIndex = categoryAssessment.fieldIndex
    let categoryValue = categoryAssessment.value
    let categoryMatch = categoryValue = row.[fieldIndex]
    let newRuleAssessments =
        Array.map2 (fun ruleAssessment ruleMatch ->
                        if ruleMatch = categoryMatch then
                            ruleAssessment + 1
                        else
                            ruleAssessment)
                   categoryAssessment.ruleAssessments
                   ruleMatches
    { categoryAssessment with ruleAssessments = newRuleAssessments }

let MatchRule (row : int[]) rule =
    let fieldIndex, eqVal = rule
    row.[fieldIndex] = eqVal

let Assess categorizeFields rules input =
  printfn "START - Assess"
  let d =
    Array.fold (fun categoryAssessment row ->
                 let ruleMatches = Array.map (MatchRule row) rules
                 Array.map (AssessCategory ruleMatches row) categoryAssessment)
               (InitAssessment categorizeFields rules)
               input
  printfn "END - Assess"
  d

let JoinAssessments assessments =
    let numAssessments = Array.length assessments
    Array.fold (fun accAssessment assessment ->
                    Array.map2 (fun accCategory category ->
                                    let newRuleAssessments =
                                        Array.map2 (+)
                                                   accCategory.ruleAssessments
                                                   category.ruleAssessments
                                    { accCategory with
                                          ruleAssessments = newRuleAssessments })
                               accAssessment
                               assessment)
               assessments.[0]
               assessments.[1..(numAssessments-1)]


let numRecords = 1000000
let numFields = 20
let numSplits = 10
let numRules = 10000
let inputs = Array.create numSplits
                          [| for i in 1 .. (numRecords / numSplits) ->
                                [| for j in 1 .. numFields ->
                                       (i % 10) + j |] |]
let categorizeFields = [| (1, 6); (2, 3); (2, 4); (3, 2) |]
let rules = [| for i in 1 .. numRules -> (i % numFields, i) |]

let assessments =
    Array.Parallel.map (Assess categorizeFields rules) inputs
    |> JoinAssessments
printfn "Assessments: %A" assessments
0
{% endhighlight %}

## program-noclass-mutable-array.fsx
{% highlight fsharp %}
// Filename: program-noclass-mutable-array.fsx
open System

type CategoryAssessment =
    { fieldIndex: int
      value: int
      mutable ruleAssessments: int[] }

let InitAssessment categorizeFields rules =
    Array.map (fun categorizeField ->
                   let fieldIndex, categoryValue = categorizeField
                   let ruleAssessments = Array.create (Array.length rules) 0
                   { CategoryAssessment.fieldIndex = fieldIndex;
                     value = categoryValue;
                     ruleAssessments = ruleAssessments })
              categorizeFields

let AssessCategory ruleMatches (row : int[]) categoryAssessment =
    let fieldIndex = categoryAssessment.fieldIndex
    let categoryValue = categoryAssessment.value
    let categoryMatch = categoryValue = row.[fieldIndex]
    Array.iteri (fun i ruleMatch ->
                     if ruleMatch = categoryMatch then
                         categoryAssessment.ruleAssessments.[i] <-
                             categoryAssessment.ruleAssessments.[i] + 1)
                ruleMatches

let MatchRule (row : int[]) rule =
    let fieldIndex, eqVal = rule
    row.[fieldIndex] = eqVal

let Assess categorizeFields rules input =
      let assessment = InitAssessment categorizeFields rules
      printfn "START - Assess"
      Array.iter (fun row ->
                      let ruleMatches = Array.map (MatchRule row) rules
                      Array.iter (AssessCategory ruleMatches row) assessment)
                 input
      printfn "END - Assess"
      assessment

let JoinAssessments assessments =
    let numAssessments = Array.length assessments
    Array.fold (fun accAssessment assessment ->
                    Array.map2 (fun accCategory category ->
                                    let newRuleAssessments =
                                        Array.map2 (+)
                                                   accCategory.ruleAssessments
                                                   category.ruleAssessments
                                    { accCategory with
                                          ruleAssessments = newRuleAssessments })
                               accAssessment
                               assessment)
               assessments.[0]
               assessments.[1..(numAssessments-1)]


let numRecords = 1000000
let numFields = 20
let numSplits = 10
let numRules = 10000
let inputs = Array.create numSplits
                          [| for i in 1 .. (numRecords / numSplits) ->
                                [| for j in 1 .. numFields ->
                                       (i % 10) + j |] |]
let categorizeFields = [| (1, 6); (2, 3); (2, 4); (3, 2) |]
let rules = [| for i in 1 .. numRules -> (i % numFields, i) |]

let assessments =
    Array.Parallel.map (Assess categorizeFields rules) inputs
    |> JoinAssessments
printfn "Assessments: %A" assessments
0
{% endhighlight %}


## program-class-mutable-array.fsx
{% highlight fsharp %}
// Filename: program-class-mutable-array.fsx
open System

type CategoryAssessment(fieldIndex : int,
                        categoryValue : int,
                        numRules : int) = class
    let mutable ruleAssessments = Array.create numRules 0
    member x.FieldIndex = fieldIndex
    member x.Value = categoryValue
    member x.RuleAssessments = ruleAssessments
    member x.IsSimilar(otherCategoryAssessment : CategoryAssessment) =
        x.FieldIndex = otherCategoryAssessment.FieldIndex &&
        x.Value = otherCategoryAssessment.Value &&
        Array.length ruleAssessments =
            Array.length otherCategoryAssessment.RuleAssessments
    member x.Merge(otherCategoryAssessment : CategoryAssessment) =
        if x.IsSimilar otherCategoryAssessment then
            ruleAssessments <- Array.map2 (+)
                                          ruleAssessments
                                          otherCategoryAssessment.RuleAssessments
        else
            failwith "ERROR: Can't merge with other CategoryAssessment"
    member x.UpRuleAssessment(index) =
        ruleAssessments.[index] <- ruleAssessments.[index] + 1
    override this.ToString() =
        sprintf "{fieldIndex = %d; value = %d; ruleAssessments = %A }"
                this.FieldIndex
                this.Value
                this.RuleAssessments
end


let InitAssessment categorizeFields rules =
    List.map (fun categorizeField ->
                  let fieldIndex, categoryValue = categorizeField
                  new CategoryAssessment(fieldIndex,
                                         categoryValue, Array.length rules))
             categorizeFields
    |> List.toArray

let AssessCategory ruleMatches
                   (row : int[])
                   (categoryAssessment : CategoryAssessment) =
    let fieldIndex = categoryAssessment.FieldIndex
    let categoryValue = categoryAssessment.Value
    let categoryMatch = categoryValue = row.[fieldIndex]
    Array.iteri  (fun i ruleMatch ->
                      if ruleMatch = categoryMatch then
                          categoryAssessment.UpRuleAssessment i)
                 ruleMatches

let MatchRule (row : int[]) rule =
    let fieldIndex, eqVal = rule
    row.[fieldIndex] = eqVal

let Assess categorizeFields rules input =
    printfn "START - Assess"
    let categoryAssessments = InitAssessment categorizeFields rules
    Array.iter (fun row ->
                    let ruleMatches = Array.map (MatchRule row) rules
                    Array.iter (AssessCategory ruleMatches row)
                               categoryAssessments)
               input
    printfn "END - Assess"
    categoryAssessments

let JoinAssessments assessments =
    let numAssessments = Array.length assessments
    Array.fold (fun accAssessment assessment ->
                    Array.iter2 (fun (accCategory : CategoryAssessment)
                                     (category : CategoryAssessment) ->
                                     accCategory.Merge category)
                                accAssessment
                                assessment
                    accAssessment)
               assessments.[0]
               assessments.[1..(numAssessments-1)]


let numRecords = 1000000
let numFields = 20
let numSplits = 1
let numRules = 10000
let inputs = Array.create numSplits
                          [| for i in 1 .. (numRecords / numSplits) ->
                                [| for j in 1 .. numFields ->
                                       (i % 10) + j |] |]
let categorizeFields = [ (1, 6); (2, 3); (2, 4); (3, 2) ]
let rules = [| for i in 1 .. numRules -> (i % numFields, i) |]
let assessments =
    Array.Parallel.map (Assess categorizeFields rules) inputs
    |> JoinAssessments
printfn "Assessments: %A" assessments
0
{% endhighlight %}
