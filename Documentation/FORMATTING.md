Currently supported languages for relative formatter are (in long form):

 **Unicode Date Field Symbol Guide**
 
 The following table is a summary of the most common configuration for Unicode Date Formatting. If you want to know more check out [Date Field Symbol Table](https://unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table) on unicode.org.

| Format  | Description | Example |
| ------------- | ------------- | ------------- |
| "y" | 1 digit min year | 1, 42, 2017 |
| "yy" | 2 digit year | 01, 42, 17 |
| "yyy" | 3 digit min year | 001, 042, 2017 |
| "yyyy" | 4 digit min year | 0001, 0042, 2017 |
| "M" | 1 digit min month | 7, 12 |
| "MM" | 2 digit month  | 07, 12 |
| "MMM" | 3 letter month abbr. | Jul, Dec |
| "MMMM" | Full month | July, December |
| "MMMMM" | 1 letter month abbr. | J, D |
| "d" | 1 digit min day | 4, 25 |
| "dd" | 2 digit day | 04, 25 |
| "E", "EE", "EEE" | 3 letter day name abbr. | Wed, Thu |
| "EEEE" | full day name | Wednesday, Thursday |
| "EEEEE" | 1 letter day name abbr. | W, T |
| "EEEEEE" | 2 letter day name abbr. | We, Th |
| "a" | Period of day | AM, PM |
| "h" | AM/PM 1 digit min hour | 5, 7 |
| "hh" | AM/PM 2 digit hour | 05, 07 |
| "H" | 24 hr 1 digit min hour | 17, 7 |
| "HH" | 24 hr 2 digit hour | 17, 07 |
| "m" | 1 digit min minute | 1, 40 |
| "mm" | 2 digit minute | 01, 40 |
| "s" | 1 digit min second | 1, 40 |
| "ss" | 2 digit second | 01, 40 |
| "S" | 10th's place of fractional second | 123ms -> 1, 7ms -> 0 |
| "SS" | 10th's & 100th's place of fractional second | 123ms -> 12, 7ms -> 00 |
| "SSS" | 10th's & 100th's & 1,000's place of fractional second | 123ms -> 123, 7ms -> 007 |