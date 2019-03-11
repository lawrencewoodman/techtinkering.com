There are a few machines I'm quite interested in comparing so I decided to create a simple Basic benchmark to get an idea of their relative speed.  The benchmark tests 7 aspects and is inspired by qsbb, which is included with the [qlay](http://web.inter.nl.net/hcc/A.Jaw.Venema/) Sinclair QL emulator.  The Basic source code for all the machines tested is available in the [GitHub repo](https://github.com/lawrencewoodman/vintage_basic_benchmark).  I chose Basic because it was available on all the machines I wanted to test and because the versions I created for each machine would require few changes.

Benchmarks are only ever a test of what you are benchmarking and there are often other tasks that the machines would do much better at.  In this case because all the benchmarks are written in Basic they are a test of both the hardware and the Basic implementation.


## Results

The results are listed below and for each the higher the number the faster they are.

<table class="neatTable">
  <tr>
    <th>Machine</th>
    <th>Basic</th>
    <th>Printing</th>
    <th>Functions</th>
    <th>Strings</th>
    <th>For Loops</th>
    <th>Gosubs</th>
    <th>Arrays</th>
    <th>Maths</th>
    <th>Average</th>
  </tr>

  <tr>
    <td>Atari ST</td>
    <td>ST Basic</td>
    <td>243</td>
    <td>177</td>
    <td>96</td>
    <td>53</td>
    <td>363</td>
    <td>269</td>
    <td>119</td>
    <td>189</td>
  </tr>

  <tr>
    <td>Amstrad CPC6128</td>
    <td>Locomotive Basic</td>
    <td>143</td>
    <td>29</td>
    <td>164</td>
    <td>39</td>
    <td>384</td>
    <td>193</td>
    <td>53</td>
    <td>144</td>
  </tr>

  <tr>
    <td>Amstrad PCW 9256</td>
    <td>Mallard Basic</td>
    <td>251</td>
    <td>26</td>
    <td>140</td>
    <td>43</td>
    <td>314</td>
    <td>173</td>
    <td>53</td>
    <td>143</td>
  </tr>

  <tr>
    <td>C128<sub>c1</sub></td>
    <td>Basic 7.0</td>
    <td>305</td>
    <td>22</td>
    <td>86</td>
    <td>32</td>
    <td>108</td>
    <td>141</td>
    <td>35</td>
    <td>104</td>
  </tr>

  <tr>
    <td>Amstrad PCW 9256</td>
    <td>Basic-80 (MBasic)</td>
    <td>214</td>
    <td>19</td>
    <td>89</td>
    <td>21</td>
    <td>240</td>
    <td>104</td>
    <td>31</td>
    <td>103</td>
  </tr>

  <tr>
    <td>C128<sub>c2</sub></td>
    <td>Basic 7.0</td>
    <td>292</td>
    <td>22</td>
    <td>82</td>
    <td>30</td>
    <td>93</td>
    <td>137</td>
    <td>35</td>
    <td>99</td>
  </tr>

  <tr>
    <td>Vic-20</td>
    <td>Basic 2</td>
    <td>267</td>
    <td>14</td>
    <td>109</td>
    <td>28</td>
    <td>140</td>
    <td>115</td>
    <td>25</td>
    <td>98</td>
  </tr>

  <tr>
    <td>Spectrum +3</td>
    <td>Basic-80 (MBasic)</td>
    <td>117</td>
    <td>18</td>
    <td>86</td>
    <td>20</td>
    <td>235</td>
    <td>101</td>
    <td>30</td>
    <td>87</td>
  </tr>

  <tr>
    <td>C64</td>
    <td>Basic 2</td>
    <td>222</td>
    <td>12</td>
    <td>92</td>
    <td>24</td>
    <td>117</td>
    <td>97</td>
    <td>21</td>
    <td>84</td>
  </tr>

  <tr>
    <td>Pet 8032</td>
    <td>Basic 4.0</td>
    <td>249</td>
    <td>12</td>
    <td>86</td>
    <td>24</td>
    <td>86</td>
    <td>98</td>
    <td>22</td>
    <td>82</td>
  </tr>

  <tr>
    <td>MFA Mikrocomputer<sub>m1</sub></td>
    <td>Basic-80 (MBasic)</td>
    <td>186</td>
    <td>14</td>
    <td>64</td>
    <td>15</td>
    <td>167</td>
    <td>77</td>
    <td>23</td>
    <td>78</td>
  </tr>

  <tr>
    <td>Sinclair QL</td>
    <td>SuperBasic</td>
    <td>112</td>
    <td>43</td>
    <td>68</td>
    <td>16</td>
    <td>93</td>
    <td>98</td>
    <td>77</td>
    <td>72</td>
  </tr>

  <tr>
    <td>Plus/4</td>
    <td>Basic 3.5</td>
    <td>180</td>
    <td>14</td>
    <td>53</td>
    <td>18</td>
    <td>70</td>
    <td>83</td>
    <td>22</td>
    <td>63</td>
  </tr>

  <tr>
    <td>C128<sub>c4</sub></td>
    <td>Basic 7.0</td>
    <td>144</td>
    <td>11</td>
    <td>41</td>
    <td>16</td>
    <td>52</td>
    <td>68</td>
    <td>17</td>
    <td>50</td>
  </tr>

  <tr>
    <td>C128<sub>c3</sub></td>
    <td>Basic 7.0</td>
    <td>148</td>
    <td>11</td>
    <td>40</td>
    <td>15</td>
    <td>45</td>
    <td>66</td>
    <td>17</td>
    <td>49</td>
  </tr>

  <tr>
    <td>C128<sub>c5</sub></td>
    <td>Basic-80 (MBasic)</td>
    <td>99</td>
    <td>9</td>
    <td>42</td>
    <td>9</td>
    <td>101</td>
    <td>52</td>
    <td>15</td>
    <td>47</td>
  </tr>

  <tr>
    <td>Spectrum 48k</td>
    <td>48 Basic</td>
    <td>88</td>
    <td>6</td>
    <td>28</td>
    <td>5</td>
    <td>27</td>
    <td>42</td>
    <td>17</td>
    <td>30</td>
  </tr>

</table>

### Notes
<sub>c1</sub> Basic 7.0, 80 column, fast mode, running <em>commodore/bench.bas</em> version</br>
<sub>c2</sub> Basic 7.0, 80 column, fast mode, running C128 windowed version: <em>commodore/bench_c128.bas</em></br>
<sub>c3</sub> Basic 7.0, 80 column, slow mode, running C128 windowed version: <em>commodore/bench_c128.bas</em></br>
<sub>c4</sub> Basic 7.0, 40 column, slow mode, running <em>commodore/bench.bas</em> version</br>
<sub>c5</sub> CP/M 80 column, running <em>cpm/mbasic.bas</em><br />
<sub>m1</sub> <a href="http://www.vcfed.org/forum/showthread.php?68776-Sinclair-Spectrum-CP-M-2-2-Creating-Fuse-Compatible-Disk-Images&p=561178#post561178">2Mhz 8085 machine</a> - Thanks to Robert<br />

## Observations
The benchmarks for a few of the machines stand out for me because they were unexpected or confirmed what I had already heard.

### Sinclair QL
The biggest surprise for me was how slow the Sinclair QL was.  I knew it was hampered by the choice of a Motorola 68008, instead of a 68000, but the benchmark indicates just what a difference this decision made.  It is particularly apparent if you consider the Amstrad PCW and Amstrad CPC6128 which were aimed at or could appeal to a similar market and deliver the sorts of speed that the QL should have delivered even if they had just stuck with the z80.  That said, when it comes to the Functions and Maths test it was ahead of all the 8-bit machines and it would have been much easier to make use of the extra memory it could address without having to resort to bank switching.

### Commodore 128
It is often said how slow CP/M was on the C128 and if you compare the benchmarks for the C128 vs the Amstrad PCW using Basic-80, it is quite clear just how slow it was.  I'm also struck by how much slower the C128 was using Basic 7.0 in slow mode than the C64 using Basic 2.  It would be interesting to know why this is.

### Atari ST
The benchmark for ST Basic, while being top of the list, probably says more about the poor implementation of Basic than it does about the Hardware itself.

### Sinclair Spectrum
I'm assuming that this benchmark was so slow because of the Basic implementation.  I would love to see the Spectrum +3 run the Basic-80 version of the benchmark under CP/M, but unfortunately I haven't been able to transfer `mbasic.com` successfully to a disk image to try it.


## Emulators

All the tests have been run on emulators as I don't have all the machines and it makes the tests easy to reproduce.  They all aim to be cycle accurate, but naturally they have to allow some flexibility otherwise they would be too resource intensive.  Therefore the benchmark figures will never be quite as accurate as running on real hardware, but should give a good indication of their speed.

<table class="neatTable">
  <tr><th>Emulator</th><th>Machines</th></tr>
  <tr>
    <td><a href="http://www.cpcwiki.eu/index.php/Arnold_(Emulator)">Arnold</a></td>
    <td>Amstrad: CPC6128</td>
  <tr>
    <td><a href="http://fuse-emulator.sourceforge.net/">Fuse</a></td>
    <td>Sinclair: Spectrum 48k</td>
  </tr>
  <tr>
    <td><a href="https://hatari.tuxfamily.org/">Hatari</a></td>
    <td>Atari: ST</td>
  </tr>
  <tr>
    <td><a href="https://www.seasip.info/Unix/Joyce/">JOYCE</a></td>
    <td>Amstrad: PCW</td>
  </tr>
  <tr>
    <td><a href="http://www.terdina.net/ql/q-emulator.html">Q-emuLator</a></td>
    <td>Sinclair: QL</td>
  </tr>
  <tr>
    <td><a href="http://vice-emu.sourceforge.net/">Vice</a></td>
    <td>Commodore: Pet, Vic-20, C64, C128, Plus/4</td>
  </tr>
</table>


## The Basic Code

I have put the Commodore Basic version below as I think it is the simplest version to understand.  In the code the variable `ti` holds the value of the system clock and is updated every 1/60th of a second.  The Basic source code for all versions are held in the [GitHub repo](https://github.com/lawrencewoodman/vintage_basic_benchmark).
<br /><br />

```` basic
10 rem basic benchmark
20 rem inspired by qsbb from qlay sinclair ql emulator
30 rem
40 rem copyright (c) 2019 lawrence woodman
50 rem licensed under an mit licence

100 rem array used later
110 dim ar(20)

200 print "basic benchmark"
210 print "7 tests, 20 seconds each"
220 print

1000 rem calculate benchmarks
1010 print
1020 print "please wait..."
1030 print

1100 rem benchmark printing
1110 t=ti
1120 p=0
1130 for i=1 to 20
1140 print ".";
1150 next i
1160 p=p+1
1170 if ti-t<=1200 then goto 1130

1300 rem benchmark functions
1310 t=ti
1320 f=0
1330 for i=1 to 20
1340 ra=sin(0.1):rb=log(4):rc=exp(10)
1350 next i
1360 f=f+1
1370 if ti-t<=1200 then goto 1330

1500 rem benchmark strings
1510 t=ti
1520 s=0
1530 for i=1 to 20
1540 a$="abcdefghijklmnopqrstuvwxyz"
1550 b$="zyxwvutsrqponmlkjihgfedcba"
1560 c$=a$+b$
1570 next i
1580 s=s+1
1590 if ti-t<=1200 then goto 1530

1700 rem benchmark for loops
1710 t=ti
1720 l=0
1730 for i=1 to 20
1740 for j=1 to 20: next j
1750 next i
1760 l=l+1
1770 if ti-t<=1200 then goto 1730

1800 rem benchmark gosubs
1810 goto 1830
1820 return
1830 t=ti
1840 g=0
1850 for i=1 to 20
1860 gosub 1820:gosub 1910
1870 next i
1880 g=g+1
1890 if ti-t<=1200 then goto 1850
1900 goto 1920
1910 return
1920 :

2000 rem benchmark arrays
2010 t=ti
2020 a=0
2030 for i=1 to 20
2040 ar(i)=i:b=ar(i)
2050 next i
2060 a=a+1
2070 if ti-t<=1200 then goto 2030


2200 rem benchmark maths
2210 t=ti
2220 m=0
2230 ka=5
2240 kb=6.2
2250 for i=1 to 20
2260 r=ka+kb-ka/kb*ka*kb
2270 r=5+6.2-5/6.2*5*6.2
2280 next i
2290 m=m+1
2300 if ti-t<=1200 then goto 2250

3010 print:print
3020 print "results"
3030 print "======="
3040 print "printing:  "; p
3050 print "functions: "; f
3060 print "strings:   "; s
3070 print "for loops: "; l
3080 print "gosubs:    "; g
3090 print "arrays:    "; a
3100 print "maths:     "; m
````
