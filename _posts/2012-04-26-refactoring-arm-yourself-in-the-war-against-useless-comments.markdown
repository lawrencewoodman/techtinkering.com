---
layout: article
title: "Refactoring: Arm Yourself in the War Against Useless Comments"
tags:
  - Programming
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Comments, comments, everywhere, but are they making your code clearer or just distracting you?  Comments are meant to be there to explain code and help you to understand it.  However, they are often out of step and therefore can confuse. Think seriously before adding comments; it is often better to refactor the code so that it doesn't need so many comments.  Less is more as far as comments go.

## Superfluous Comments
At one time most universities and colleges really pushed students to add comments to make their code clearer.  Unfortunately this often ended up with comments just reiterating what the code was doing, thereby breaking the [DRY Principle](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself "Don't repeat yourself"):
{% highlight c %}
i = 0;    /* Initialize i */

/* Open file */
if ((fp = fopen(filename, "r")) != NULL) {
  /* Read all the bytes until End-Of-File */
  while ((ch = fgetc(fp)) != EOF) {
    /* Output character */
    printf("%c", ch);  
    i++;    /* Increment i */
  }
  /* Close file */
  fclose(fp);
}
{% endhighlight %}

I wish that I could say that this no longer happens, but some programmers seem to have trouble shaking off this _commenting for the sake of commenting_ mind set.  I think that the code above is actually clearer without the comments:
{% highlight c %}
i = 0;

if ((fp = fopen(filename, "r")) != NULL) {
  while ((ch = fgetc(fp)) != EOF) {
    printf("%c", ch);  
    i++;
  }
  fclose(fp);
}
{% endhighlight %}

## Comments Lie

I have lost count of the number of times that I have seen comments express the exact opposite of the code.  Sure the following line from above was pointless:
{% highlight c %}
i++;    /* Increment i */
{% endhighlight %}

But what about:
{% highlight c %}
i--;    /* Increment i */
{% endhighlight %}

It is no wonder that this sort of thing happens; a large part of programming is trying things out to see what works.  You may have good intentions with your comments the first time you write something, but are you really going to change the comment each time your ideas change?  The main thing to remember is that _you will rarely read your own comments_ and hence not realize when they are wrong.

## Refactor Rather Than Comment
Comments should not be used as a crutch to support poor code.  Wherever possible make the code clear through good use of variable names and methods to describe use and intention.  Let the code explains itself.  Once you have clear code you can easily test it; something that you can't do with comments.

The following is inspired by code from [xAce](http://lawrencewoodman.github.com/xAce/ "A Jupiter Ace Emulator").  It is not at all obvious what the code inside the function is doing, nor what is expected to be passed to `save_p()`.
{% highlight c %}
bool
save_p(char *mem, int _de)
{
  const char end[] = {'.', 't', 'a', 'p', '\0'};
  char filename[15];
  char sum = 0;
  FILE *fp;
  int i;

  for (i = 0; !isspace(mem[i]) && i < 10; i++) {
    filename[i]=mem[i];
  }

  strcpy(filename+i, end);

  for (i = 0; i < _de; i++) {
    sum ^= mem[i];
  }

  if ((fp = fopen(filename,"wb")) != NULL) {
    fputc((_de)&0xff,fp);
    fputc(((_de)>>8)&0xff,fp);
    fwrite(mem,1,_de,fp);
    fputc(sum, _de), fp);
    fclose(fp);
  }

  return fp != NULL;
}
{% endhighlight %}



By moving some of the functionality into separate functions and renaming the variables and parameters it is much easier to see what is happening:
{% highlight c %}
bool
save_program(char *program, int program_size)
{
  char filename[15];
  char checksum;
  FILE *fp;

  create_filename(filename, program);
  checksum = calc_checksum(program, program_size);

  if ((fp = fopen(filename,"wb")) != NULL) {
    fputc( low_byte(program_size), fp);
    fputc( high_byte(program_size), fp);
    fwrite(program, sizeof(*program), program_size, fp);
    fputc(checksum, fp);
    fclose(fp);
  }

  return fp != NULL
}

static void
create_filename(char filename[15], char *program)
{
  const char filename_suffix[] = {'.', 't', 'a', 'p', '\0'};
  int i;
  
  for (i = 0; !isspace(program[i]) && i < 10; i++)
    filename[i] = program[i];

  strcpy(filename+i, filename_suffix);
}

static char
calc_checksum(char *data, int data_size)
{
  char checksum = 0;
  int i;

  for (i = 0; i < data_size; i++)
    checksum ^= data[i];

  return checksum;
}

static unsigned char
low_byte(int word) { return(word & 0xff); }

static unsigned char
high_byte(int word) { return(word >> 8); }
{% endhighlight %}


The code is a little longer, but ask yourself "<em>Which code would you prefer to debug or modify?</em>"  As far as what to refactor, this will come with experience and familiarity with the common idioms for the language that you are using.  There are a number of ways that the above could have been done, but this way worked for me.

## Consider Using Assertions Rather Than Comments
The oft repeated reason for comments is to let people know what you can and can not pass to a function.  I like to try and keep everything in code.  To do this you can use assertions.  So in the `save_program()` example above, instead of using comments:
{% highlight c %}
/* 0 < program_size <= 65535 */
bool
save_program(char *program, int program_size)
{
  char filename[15];
  char checksum;
{% endhighlight %}

Put this into the code using an assertion:
{% highlight c %}
bool
save_program(char *program, int program_size)
{
  assert(program_size > 0 && program_size <= 65535);

  char filename[15];
  char checksum;
{% endhighlight %}

Now the assertions can be tested and kept up-to-date.  Of course, assertions can be ugly if overused, so check the data at point of entry and after that trust that it is still correct.  It is worth noting that this is not an alternative to good api documentation, where comments definitely should be used.


## Won't All These Extra Methods Make it Slow?
It depends on how you do it, modern compilers are pretty clever and you can often tell the compiler to inline methods if needed.  You may also want to consider wrapping some of the `assert()` statements so that they are only called when in _Debug_ mode.  In general though, I find that the performance difference isn't noticeable, but the maintainability is increased dramatically.

## When Should I Use Comments?
Comments are useful to say why you did something and to state requirements.  They are also great for documenting the api, particularly when they are meant to be parsed by external tools.  If you want other people to use your library, you have to reduce the barriers to their doing so.  Being able to quickly understand the api, will make it much more likely that it gets adopted.

In short: _Use comments for what you can't say in code_.

