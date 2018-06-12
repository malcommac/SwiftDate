//
//  Locales.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 08/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public protocol LocaleTableProtocol {
	var code: String { get }
	var table: [String: Any] { get }
	func quantifyKey(_ value: Double) -> String?
	
	init()
}

public class locale_it: LocaleTableProtocol {
	
	public required init() {}
	
	public func quantifyKey(_ value: Double) -> String? {
		return (Int(value) == 1 ? "one" : "other")
	}
	
	public var code: String = "it"
	
	public var table: [String: Any] {
		let style_long : [String:Any] = [
			"year": [
				"previous": "anno scorso",
				"current": "quest’anno",
				"next": "anno prossimo",
				"past": [
					"one": "{0} anno fa",
					"other": "{0} anni fa"
				],
				"future": [
					"one": "tra {0} anno",
					"other": "tra {0} anni"
				]
			],
			"quarter": [
				"previous": "trimestre scorso",
				"current": "questo trimestre",
				"next": "trimestre prossimo",
				"past": [
					"one": "{0} trimestre fa",
					"other": "{0} trimestri fa"
				],
				"future": [
					"one": "tra {0} trimestre",
					"other": "tra {0} trimestri"
				]
			],
			"month": [
				"previous": "mese scorso",
				"current": "questo mese",
				"next": "mese prossimo",
				"past": [
					"one": "{0} mese fa",
					"other": "{0} mesi fa"
				],
				"future": [
					"one": "tra {0} mese",
					"other": "tra {0} mesi"
				]
			],
			"week": [
				"previous": "settimana scorsa",
				"current": "questa settimana",
				"next": "settimana prossima",
				"past": [
					"one": "{0} settimana fa",
					"other": "{0} settimane fa"
				],
				"future": [
					"one": "tra {0} settimana",
					"other": "tra {0} settimane"
				]
			],
			"day": [
				"previous": "ieri",
				"current": "oggi",
				"next": "domani",
				"past": [
					"one": "{0} giorno fa",
					"other": "{0} giorni fa"
				],
				"future": [
					"one": "tra {0} giorno",
					"other": "tra {0} giorni"
				]
			],
			"hour": [
				"current": "quest’ora",
				"past": [
					"one": "{0} ora fa",
					"other": "{0} ore fa"
				],
				"future": [
					"one": "tra {0} ora",
					"other": "tra {0} ore"
				]
			],
			"minute": [
				"current": "questo minuto",
				"past": [
					"one": "{0} minuto fa",
					"other": "{0} minuti fa"
				],
				"future": [
					"one": "tra {0} minuto",
					"other": "tra {0} minuti"
				]
			],
			"second": [
				"current": "ora",
				"past": [
					"one": "{0} secondo fa",
					"other": "{0} secondi fa"
				],
				"future": [
					"one": "tra {0} secondo",
					"other": "tra {0} secondi"
				]
			],
			"now": "ora"
		]
		
		return [
			"long": style_long
		]
	}
	
	
}
