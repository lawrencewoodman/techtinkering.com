When programming using machine code there are a few useful aids that can make it easier to do.  I have created a couple of tables for the 6502 that can make the process easier.  They are based on tables found in 'Machine Code for Beginners', which <a href="https://usborne.com/browse-books/features/computer-and-coding-books/">Usborne have made available as a PDF for free</a>.

## 6502 Machine Language Hex Codes
When writing a program in machine code we need to be able to quickly find the machine language hex code for the instruction we want to enter.  The following table should make this fairly simple.
<img src="/img/articles/6502_machine_language_hex_codes_table.jpg" class="img-left" style="width: 100%; clear: left;" title="6502 Machine Language Hex Code Table">
<br style="clear:left"/><br />

## Two's Complement Hex Code
If we need to use a negative number such as when using relative addresses, then the following table will allow us to quickly find the correct hex code to use.  For example the two's complement of `-92` in hex is `A4`.
<img src="/img/articles/8_bit_twos_complement_hex_table.jpg" class="img-left" style="width: 100%; clear: left;" title="8-bit Two's Complement Hex Table">
<br style="clear:left"/><br />

## Source Files

If you want to alter these tables, I have put the original files used to create them in a [repo](https://github.com/lawrencewoodman/machine_language_aids) on GitHub.
