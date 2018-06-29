<p align="center" >
<img src="Documentation/SwiftDate.png" width=597px alt="SwiftDate" title="SwiftDate">
</p>


SwiftDate is the definitive toolchain to manipulate and display dates and time zones on all Apple platform and even on Linux and Swift Server Side frameworks like Vapor or Kitura.

#### What you can do?

##### Parsing
Date parsing made easy; all major formats are automatically recognized (ISO8601, RSS, Alt RSS, .NET, SQL, HTTP...) and you can also provide your own format:

```swift
// All defaults datetime formats (15+) are recognized automatically
let _ = "2010-05-20 15:30:00".toDate()

// You can also provide your own format!
let _ = "2010-05-20 15:30".toDate("yyyy-MM-dd HH:mm")

// All ISO8601 variants are supported too!
let _ = "2017-09-17T11:59:29+02:00".toISODate()

// RSS, Extended, HTTP, SQL, .NET and all the major variants are supported!
let _ = "19 Nov 2015 22:20:40 +0100".toRSS(alt: true)

```