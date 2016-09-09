//
//  DirectionUnit.swift
//  YahooWeatherSource
//
//  Created by Yaxin Cheng on 2016-08-30.
//  Copyright © 2016 Yaxin Cheng. All rights reserved.
//

import Foundation

public enum DirectionUnit: UnitConvertibleProtocol {
	case degree
	case direction
	
	/**
	Convert distance unit in weather json or forecast json
	- Parameter value: json needs to be converted
	*/
	func convert(value: Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
		let directionKey = "windDirection"
		guard self == .direction, let windDirection = (value[directionKey] as? NSString)?.doubleValue else { return value }
		
		let windDegree: Double
		if windDirection < 0 {
			windDegree = 360 + windDirection
		} else if windDirection > 360 {
			windDegree = Double(Int(windDirection) % 360)
		} else {
			windDegree = windDirection
		}
		
		let degree = convert(degree: windDegree)
		var convertedJSON = value
		convertedJSON[directionKey] = degree
		return convertedJSON
	}
}