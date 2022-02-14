//
//  File.swift
//  
//
//  Created by Daniele Margutti on 14/02/22.
//

import Foundation

/// Style used to format month, weekday, quarter symbols.
/// Stand-alone properties are for use in places like calendar headers.
/// Non-stand-alone properties are for use in context (for example, “Saturday, November 12th”).
///
/// - `default`: Default formatter (ie. `4th quarter` for quarter, `April` for months and `Wednesday` for weekdays)
/// - `defaultStandalone`:  See `default`; See `short`; stand-alone properties are for use in places like calendar headers.
/// - `short`: Short symbols (ie. `Jun` for months, `Fri` for weekdays, `Q1` for quarters).
/// - `veryShort`: Very short symbols (ie. `J` for months, `F` for weekdays, for quarter it just return `short` variant).
/// - `standaloneShort`: See `short`; stand-alone properties are for use in places like calendar headers.
/// - `standaloneVeryShort`: See `veryShort`; stand-alone properties are for use in places like calendar headers.
public enum DateSymbolFormats {
    case `default`
    case defaultStandalone
    case short
    case veryShort
    case standaloneShort
    case standaloneVeryShort
}
