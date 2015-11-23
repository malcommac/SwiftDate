# SwiftDate 2
### Probability the best way to play with Dates in iOS, Mac, WatchOS and yeah, tvOS!


Welcome to SwiftDate 2, the next iteration of SwiftDate's Dates Managament Library made 100% with Swift 2 in mind. The goal of this project is to bring NSDate to the next level with the power of the Apple's new programming language.
SwiftDate has all you need to manage dates components, timezones and locales easily in Swift: you will not belive what we have made for you.
So let's get a look at it!

## NSDate Main Concepts

As you know NSDate is the central class of the date/time handling in Foundation framework. In fact NSDate is nothing more than a wrapper around the number of seconds since [Jan 1, 2001 at 00:00 UTC](http://en.wikipedia.org/wiki/Coordinated_Universal_Time) (or GMT if you prefer).
For values representing number of seconds, Foundation uses NSTimeInterval which is a 64-bit floating point value. 

According to Apple's documentation is enough impressive to yield [sub-millisecond precision over a range of 10'000 years](http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_DataTypes/Reference/reference.html#//apple_ref/doc/uid/20000018-SW69); pretty good uh?

So an NSDate object **always represent absolute point in time, and always in UTC format**.
Moreover due to this type of representation **you cannot create a date without including a specific time** (so you cannot create something like Dec 25, 2015 but you need to make something like Dec 25, 2015 at 00:00:00 UTC; this is important when you need to compare dates).

Another important lesson is this: **NSDate has no concept of time zones**. For examle when in London is midnight in New York it is only 6pm of the day before: **both of these dates represent the same point in time and are absolute equals as far for NSDate** (the number of seconds since Jan 1,2001 00:00 remember?).
This important concept is the root of several problems for programmers who are approaching date management in Cocoa.

This one of the problems which we have tried to solve with this library: a painless management of timezones and a power solution to manage date components and operations.

The following chapter will let you know two base classes you can use along with NSDate to better handle timezones and other useful properties related to time/date management.

## SwiftDate Main Concepts

SwiftDate is composed by:

* a **DateInRegion class** which incapsulate a NSDate object and time zone/calendar/locale settings and allows you to represent and work with a date in a specific place of the world.
* a **Region structure** which allows you to represent world's regions and settings to associate to DateInRegion instances
* a **set of NSDate extensions** with properties and methods to manage operation and components of date instances
* a **set of extensions** to various classes and data types involved in date management which allows you to make operations and comparisons between dates

Don't be worried by these nerdy stuff, **the only need you know if while NSDate still represent an UTC absolute time, DateInRegion represent a date in a certain zone of our planet**.

### 1. Create an NSDate

#### Create Dates from Strings
You can create NSDate objects from string using a custom formatter or one of the one provided by SwiftDate:

```swift
let UTCDate :NSDate = "2015-01-05T22:10:55.200Z".toDate(DateFormat.ISO8601)

```






## Overview

**Mou**, the missing Markdown editor for *web developers*.

### Syntax

#### Strong and Emphasize 

**strong** or __strong__ ( Cmd + B )

*emphasize* or _emphasize_ ( Cmd + I )

**Sometimes I want a lot of text to be bold.
Like, seriously, a _LOT_ of text**

#### Blockquotes

> Right angle brackets &gt; are used for block quotes.

#### Links and Email

An email <example@example.com> link.

Simple inline link <http://chenluois.com>, another inline link [Smaller](http://25.io/smaller/), one more inline link with title [Resize](http://resizesafari.com "a Safari extension").

A [reference style][id] link. Input id, then anywhere in the doc, define the link with corresponding id:

[id]: http://25.io/mou/ "Markdown editor on Mac OS X"

Titles ( or called tool tips ) in the links are optional.

#### Images

An inline image ![Smaller icon](http://25.io/smaller/favicon.ico "Title here"), title is optional.

A ![Resize icon][2] reference style image.

[2]: http://resizesafari.com/favicon.ico "Title"

#### Inline code and Block code

Inline code are surround by `backtick` key. To create a block code:

	Indent each line by at least 1 tab, or 4 spaces.
    var Mou = exactlyTheAppIwant; 

####  Ordered Lists

Ordered lists are created using "1." + Space:

1. Ordered list item
2. Ordered list item
3. Ordered list item

#### Unordered Lists

Unordered list are created using "*" + Space:

* Unordered list item
* Unordered list item
* Unordered list item 

Or using "-" + Space:

- Unordered list item
- Unordered list item
- Unordered list item

#### Hard Linebreak

End a line with two or more spaces will create a hard linebreak, called `<br />` in HTML. ( Control + Return )  
Above line ended with 2 spaces.

#### Horizontal Rules

Three or more asterisks or dashes:

***

---

- - - -

#### Headers

Setext-style:

This is H1
==========

This is H2
----------

atx-style:

# This is H1
## This is H2
### This is H3
#### This is H4
##### This is H5
###### This is H6


### Extra Syntax

#### Footnotes

Footnotes work mostly like reference-style links. A footnote is made of two things: a marker in the text that will become a superscript number; a footnote definition that will be placed in a list of footnotes at the end of the document. A footnote looks like this:

That's some text with a footnote.[^1]

[^1]: And that's the footnote.


#### Strikethrough

Wrap with 2 tilde characters:

~~Strikethrough~~


#### Fenced Code Blocks

Start with a line containing 3 or more backticks, and ends with the first line with the same number of backticks:

```
Fenced code blocks are like Stardard Markdown’s regular code
blocks, except that they’re not indented and instead rely on
a start and end fence lines to delimit the code block.
```

#### Tables

A simple table looks like this:

First Header | Second Header | Third Header
------------ | ------------- | ------------
Content Cell | Content Cell  | Content Cell
Content Cell | Content Cell  | Content Cell

If you wish, you can add a leading and tailing pipe to each line of the table:

| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |

Specify alignment for each column by adding colons to separator lines:

First Header | Second Header | Third Header
:----------- | :-----------: | -----------:
Left         | Center        | Right
Left         | Center        | Right


### Shortcuts

#### View

* Toggle live preview: Shift + Cmd + I
* Toggle Words Counter: Shift + Cmd + W
* Toggle Transparent: Shift + Cmd + T
* Toggle Floating: Shift + Cmd + F
* Left/Right = 1/1: Cmd + 0
* Left/Right = 3/1: Cmd + +
* Left/Right = 1/3: Cmd + -
* Toggle Writing orientation: Cmd + L
* Toggle fullscreen: Control + Cmd + F

#### Actions

* Copy HTML: Option + Cmd + C
* Strong: Select text, Cmd + B
* Emphasize: Select text, Cmd + I
* Inline Code: Select text, Cmd + K
* Strikethrough: Select text, Cmd + U
* Link: Select text, Control + Shift + L
* Image: Select text, Control + Shift + I
* Select Word: Control + Option + W
* Select Line: Shift + Cmd + L
* Select All: Cmd + A
* Deselect All: Cmd + D
* Convert to Uppercase: Select text, Control + U
* Convert to Lowercase: Select text, Control + Shift + U
* Convert to Titlecase: Select text, Control + Option + U
* Convert to List: Select lines, Control + L
* Convert to Blockquote: Select lines, Control + Q
* Convert to H1: Cmd + 1
* Convert to H2: Cmd + 2
* Convert to H3: Cmd + 3
* Convert to H4: Cmd + 4
* Convert to H5: Cmd + 5
* Convert to H6: Cmd + 6
* Convert Spaces to Tabs: Control + [
* Convert Tabs to Spaces: Control + ]
* Insert Current Date: Control + Shift + 1
* Insert Current Time: Control + Shift + 2
* Insert entity <: Control + Shift + ,
* Insert entity >: Control + Shift + .
* Insert entity &: Control + Shift + 7
* Insert entity Space: Control + Shift + Space
* Insert Scriptogr.am Header: Control + Shift + G
* Shift Line Left: Select lines, Cmd + [
* Shift Line Right: Select lines, Cmd + ]
* New Line: Cmd + Return
* Comment: Cmd + /
* Hard Linebreak: Control + Return

#### Edit

* Auto complete current word: Esc
* Find: Cmd + F
* Close find bar: Esc

#### Post

* Post on Scriptogr.am: Control + Shift + S
* Post on Tumblr: Control + Shift + T

#### Export

* Export HTML: Option + Cmd + E
* Export PDF:  Option + Cmd + P


### And more?

Don't forget to check Preferences, lots of useful options are there.

Follow [@Mou](https://twitter.com/mou) on Twitter for the latest news.

For feedback, use the menu `Help` - `Send Feedback`