BASIC programs are stored in memory using a simple structure that we can investigate and manipulate.  This article will show how they are stored and contains a BASIC program to go through each line of its own code and display how it is stored in memory.  A good understanding of how BASIC is stored can help us to find novel ways to get the most out of BASIC and to leverage the power of the BASIC interpreter.  This can be seen in a previous article: [Storing Machine Code in REM Statements on the VIC-20](/articles/storing-machine-code-in-rem-statements-on-the-vic-20/).

A BASIC program consists of a series of lines.  Each line has a link to the next line in memory, followed by a line number, then one or more BASIC statements and the end of the line is indicated with a 00 byte.  The end of the program is indicated by two 00 bytes in the next line link.

<img src="/img/articles/vic20_basic_lines_memory_layout.png" class="img-right" style="width: 100%; margin-bottom: 2em;" title="Layout of BASIC lines in memory">


BASIC programs start at different locations depending on how much memory the Vic has and this can be seen in the following table.

<table class="neatTable">
  <tr>
    <th>Memory</th>
    <th>BASIC Storage</th>
    <th>First Location of BASIC Program</th>
  </tr>
  <tr>
    <td>Unexpanded</td>
    <td>$1000-$1DFF (4096-7679)</td>
    <td>$1001 (4097)</td>
  </tr>
  <tr>
    <td>+3K</td>
    <td>$0400-$1DFF (1024-7679)</td>
    <td>$0401 (1025)</td>
  </tr>
  <tr>
    <td>+8K</td>
    <td>$1200-$3FFF (4608-16383)</td>
    <td>$1201 (4609)</td>
  <tr>
    <td>+16K</td>
    <td>$1200-$5FFF (4608-24575)</td>
    <td>$1201 (4609)</td>
  </tr>
  <tr>
    <td>+24K</td>
    <td>$1200-$7FFF (4608-32767)</td>
    <td>$1201 (4609)</td>
  </tr>

  </tr>
</table>

In order to reduce the storage requirements of a BASIC program and to speed up the interpreter, BASIC statements are condensed using tokens.  The following table contains the [tokens used by BASIC v2 on the Vic](https://archive.org/details/COMPUTEs_Mapping_the_VIC_1984_COMPUTE_Publications/page/n337/mode/2up "Mapping the Vic by Russ Davies, Appendix C").  Where tokens aren't used, PETSCII takes it place in the case of comments, variable names, numbers, etc.

<div class="overflow-auto"><table class="neatTable">
  <tr><th>Decimal</th><th>Hex</th><th>BASIC token</th>
      <th>Decimal</th><th>Hex</th><th>BASIC token</th>
  </tr>
  <tr><td>128</td><td>80</td><td>END</td><td>166</td><td>A6</td><td>SPC(</td></tr>
  <tr><td>129</td><td>81</td><td>FOR</td><td>167</td><td>A7</td><td>THEN</td></tr>
  <tr><td>130</td><td>82</td><td>NEXT</td><td>168</td><td>A8</td><td>NOT</td></tr>
  <tr><td>131</td><td>83</td><td>DATA</td><td>169</td><td>A9</td><td>STEP</td></tr>
  <tr><td>132</td><td>84</td><td>INPUT#</td><td>170</td><td>AA</td><td>+</td></tr>
  <tr><td>133</td><td>85</td><td>INPUT</td><td>171</td><td>AB</td><td>-</td></tr>
  <tr><td>134</td><td>86</td><td>DIM</td><td>172</td><td>AC</td><td>*</td></tr>
  <tr><td>135</td><td>87</td><td>READ</td><td>173</td><td>AD</td><td>/</td></tr>
  <tr><td>136</td><td>88</td><td>LET</td><td>174</td><td>AE</td><td>^</td></tr>
  <tr><td>137</td><td>89</td><td>GOTO</td><td>175</td><td>AF</td><td>AND</td></tr>
  <tr><td>138</td><td>8A</td><td>RUN</td><td>176</td><td>B0</td><td>OR</td></tr>
  <tr><td>139</td><td>8B</td><td>IF</td><td>177</td><td>B1</td><td>&GT;</td></tr>
  <tr><td>140</td><td>8C</td><td>RESTORE</td><td>178</td><td>B2</td><td>=</td></tr>
  <tr><td>141</td><td>8D</td><td>GOSUB</td><td>179</td><td>B3</td><td>&LT;</td></tr>
  <tr><td>142</td><td>8E</td><td>RETURN</td><td>180</td><td>B4</td><td>SGN</td></tr>
  <tr><td>143</td><td>8F</td><td>REM</td><td>181</td><td>B5</td><td>INT</td></tr>
  <tr><td>144</td><td>90</td><td>STOP</td><td>182</td><td>B6</td><td>ABS</td></tr>
  <tr><td>145</td><td>91</td><td>ON</td><td>183</td><td>B7</td><td>USR</td></tr>
  <tr><td>146</td><td>92</td><td>WAIT</td><td>184</td><td>B8</td><td>FRE</td></tr>
  <tr><td>147</td><td>93</td><td>LOAD</td><td>185</td><td>B9</td><td>POS</td></tr>
  <tr><td>148</td><td>94</td><td>SAVE</td><td>186</td><td>BA</td><td>SQR</td></tr>
  <tr><td>149</td><td>95</td><td>VERIFY</td><td>187</td><td>BB</td><td>RND</td></tr>
  <tr><td>150</td><td>96</td><td>DEF</td><td>188</td><td>BC</td><td>LOG</td></tr>
  <tr><td>151</td><td>97</td><td>POKE</td><td>189</td><td>BD</td><td>EXP</td></tr>
  <tr><td>152</td><td>98</td><td>PRINT#</td><td>190</td><td>BE</td><td>COS</td></tr>
  <tr><td>153</td><td>99</td><td>PRINT</td><td>191</td><td>BF</td><td>SIN</td></tr>
  <tr><td>154</td><td>9A</td><td>CONT</td><td>192</td><td>C0</td><td>TAN</td></tr>
  <tr><td>155</td><td>9B</td><td>LIST</td><td>193</td><td>C1</td><td>ATN</td></tr>
  <tr><td>156</td><td>9C</td><td>CLR</td><td>194</td><td>C2</td><td>PEEK</td></tr>
  <tr><td>157</td><td>9D</td><td>CMD</td><td>195</td><td>C3</td><td>LEN</td></tr>
  <tr><td>158</td><td>9E</td><td>SYS</td><td>196</td><td>C4</td><td>STR$</td></tr>
  <tr><td>159</td><td>9F</td><td>OPEN</td><td>197</td><td>C5</td><td>VAL</td></tr>
  <tr><td>160</td><td>A0</td><td>CLOSE</td><td>198</td><td>C6</td><td>ASC</td></tr>
  <tr><td>161</td><td>A1</td><td>GET</td><td>199</td><td>C7</td><td>CHR$</td></tr>
  <tr><td>162</td><td>A2</td><td>NEW</td><td>200</td><td>C8</td><td>LEFT$</td></tr>
  <tr><td>163</td><td>A3</td><td>TAB(</td><td>201</td><td>C9</td><td>RIGHT$</td></tr>
  <tr><td>164</td><td>A4</td><td>TO</td><td>202</td><td>CA</td><td>MID$</td></tr>
  <tr><td>165</td><td>A5</td><td>FN</td><td>203</td><td>CB</td><td>GO</td></tr>
</table></div>


## An Example BASIC Program Structure

As an example we'll look at how the following short BASIC program is stored in memory.

```
10 REM A COMMENT
20 N=4*3:PRINT N
```

On an unexpanded Vic, BASIC starts at 4097 ($1001) and this table shows how the program is stored in memory.  The two-byte values are stored in memory in LSB MSB order and in the table this is how they are listed in the hex column with the 16-bit value in MSB LSB order in parenthesis.

<div class="overflow-auto"><table class="neatTable">
  <tr><th>Address</th><th>Contents<br />(decimal)</th><th>Contents<br />(hex)</th><th>Meaning</th><th>Type</th></tr>
  <tr><td>4097</td><td>4113</td><td>1110 ($1011)</td><td><em>Next Line Link</em></td><td></td></tr>
  <tr><td>4099</td><td>0010</td><td>0A00 ($000A)</td><td><em>Line Number</em></td><td></td></tr>
  <tr><td>4101</td><td>143</td><td>8F</td><td>REM</td><td>Token</td></tr>
  <tr><td>4102</td><td>32</td><td>20</td><td>&lt;space&gt;</td><td>PETSCII</td></tr>
  <tr><td>4103</td><td>65</td><td>41</td><td>A</td><td>PETSCII</td></tr>
  <tr><td>4104</td><td>32</td><td>20</td><td>&lt;space&gt;</td><td>PETSCII</td></tr>
  <tr><td>4105</td><td>67</td><td>43</td><td>C</td><td>PETSCII</td></tr>
  <tr><td>4106</td><td>79</td><td>4F</td><td>O</td><td>PETSCII</td></tr>
  <tr><td>4107</td><td>77</td><td>4D</td><td>M</td><td>PETSCII</td></tr>
  <tr><td>4108</td><td>77</td><td>4D</td><td>M</td><td>PETSCII</td></tr>
  <tr><td>4109</td><td>69</td><td>45</td><td>E</td><td>PETSCII</td></tr>
  <tr><td>4110</td><td>78</td><td>4E</td><td>N</td><td>PETSCII</td></tr>
  <tr><td>4111</td><td>84</td><td>54</td><td>T</td><td>PETSCII</td></tr>
  <tr><td>4112</td><td>0</td><td>00</td><td><em>End of Line</em></td><td></td></tr>
  <tr><td>&nbsp;</td><td></td><td></td><td></td><td></td></tr>
  <tr><td>4113</td><td>4127</td><td>1F10 ($101F)</td><td><em>Next Line Link</em></td><td></td></tr>
  <tr><td>4115</td><td>0020</td><td>1400 ($0014)</td><td><em>Line Number</em></td><td></td></tr>
  <tr><td>4117</td><td>78</td><td>4E</td><td>N</td><td>PETSCII</td></tr>
  <tr><td>4118</td><td>178</td><td>B2</td><td>=</td><td>Token</td></tr>
  <tr><td>4119</td><td>52</td><td>34</td><td>4</td><td>PETSCII</td></tr>
  <tr><td>4120</td><td>172</td><td>AC</td><td>*</td><td>Token</td></tr>
  <tr><td>4121</td><td>51</td><td>33</td><td>3</td><td>PETSCII</td></tr>
  <tr><td>4122</td><td>58</td><td>3A</td><td>:</td><td>PETSCII</td></tr>
  <tr><td>4123</td><td>153</td><td>99</td><td>PRINT</td><td>Token</td></tr>
  <tr><td>4124</td><td>32</td><td>20</td><td>&lt;space&gt;</td><td>PETSCII</td></tr>
  <tr><td>4125</td><td>78</td><td>4E</td><td>N</td><td>PETSCII</td></tr>
  <tr><td>4126</td><td>0</td><td>00</td><td><em>End of Line</em></td><td></td></tr>
  <tr><td>&nbsp;</td><td></td><td></td><td></td><td></td></tr>
  <tr><td>4127</td><td>0000</td><td></td><td><em>End of Program</em></td><td></td></tr>
</table></div>


## Video

The following video displays a BASIC program's structure and encoding in memory using the program below and VICMON.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/Bh380PVz-LY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


## Program to Display Structure of Basic Program

The following program will go through each of its BASIC lines and show the structure and encoding.

```
100 REM PRINT BASIC STRUCTURE
110 P=PEEK(43)+PEEK(44)*256:REM START OF BASIC
120 GOSUB 5000
130 LL=PEEK(P)+256*PEEK(P+1)
140 LN=PEEK(P+2)+256*PEEK(P+3)
150 GOSUB 1000
160 P=LL
170 IF LL <> 0 THEN GOTO 130
180 END

1000 REM PRINT LINE STRUCTURE
1010 IF LL=0 THEN PRINT P;LL;TAB(12);"*EOP":RETURN
1020 PRINT:GOSUB 4000:PRINT
1030 PRINT P;LL;TAB(12);"*LINK"
1040 PRINT P+2;LN;TAB(12);"*LINE NUM"
1050 P=P+4
1060 B=PEEK(P)
1070 PRINT P;B;TAB(12);
1080 GOSUB 3000:PRINT
1090 P=P+1
1100 GOSUB 2000
1110 IF B <> 0 GOTO 1060
1120 PRINT
1130 RETURN

2000 REM DELAY
2010 FOR I=1 TO 150
2020 NEXT I
2030 RETURN

3000 REM PRINT TOKEN OR CHAR
3010 IF PL = 0 AND B=0 THEN PRINT "*EOL"
3020 IF PL = 0 AND B=32 THEN PRINT "[SPACE]";
3030 IF B >= 128 AND B <= 203 THEN PRINT T$(B-128);:RETURN
3040 PRINT CHR$(B);
3050 RETURN

4000 REM PRINT BASIC LINE
4010 PRINT LN;
4020 BL=P+4
4030 B=PEEK(BL)
4040 IF B = 0 THEN 4080
4050 PL=1:GOSUB 3000:PL=0
4060 BL=BL+1
4070 GOTO 4030
4080 PRINT
4090 RETURN

5000 REM LOAD TOKENS
5010 DIM T$(76)
5020 FOR I=0TO75
5030 READ T$(I)
5040 NEXT I
5050 RETURN

6000 REM TOKENS
6010 DATA "END","FOR","NEXT","DATA","INPUT#","INPUT"
6020 DATA "DIM","READ","LET","GOTO","RUN","IF","RESTORE"
6030 DATA "GOSUB","RETURN","REM","STOP","ON","WAIT","LOAD"
6040 DATA "SAVE","VERIFY","DEF","POKE","PRINT#","PRINT"
6050 DATA "CONT","LIST","CLR","CMD","SYS","OPEN","CLOSE"
6060 DATA "GET","NEW","TAB(","TO","FN","SPC(","THEN","NOT"
6070 DATA "STEP","+","-","*","/","^","AND","OR",">","="
6080 DATA "<","SGN","INT","ABS","USR","FRE","POS","SQR"
6090 DATA "RND","LOG","EXP","COS","SIN","TAN","ATN"
6100 DATA "PEEK","LEN","STR$","VAL","ASC","CHR$","LEFT$"
6110 DATA "RIGHT$","MID$","GO"
```
