// CocoPlus - NSColor+CocoPlus.h
//   ___	       , __
//  / (_)	      /|/  \ |\
// |	  __   __  __  |___/ | |	__
// |	 / (\_/   / (\_|     |/  |  |  / _\_
//  \___/\__/ \__/\__/ | ___/|__/|_/|_/  \/
// Copyright © 2013 Manuel Sainz de Baranda y Goñi.
// Released under the terms of the GNU Lesser General Public License v3.

#import <AppKit/AppKit.h>

@interface NSColor (CocoPlus)

	+ (NSColor *) colorFromFloatString: (NSString *) string;

	- (NSString *) floatRGBString;

@end

// EOF
