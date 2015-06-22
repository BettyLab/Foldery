// CocoPlus - NSImage+CocoPlus.h
//   ___	       , __
//  / (_)	      /|/  \ |\
// |	  __   __  __  |___/ | |	__
// |	 / (\_/   / (\_|     |/  |  |  / _\_
//  \___/\__/ \__/\__/ | ___/|__/|_/|_/  \/
// Copyright © 2013-2014 Manuel Sainz de Baranda y Goñi.
// Released under the terms of the GNU Lesser General Public License v3.

#import <Cocoa/Cocoa.h>

@interface NSImage (CocoPlus)

	- (NSImageRep *) findRepresentationOfSize: (NSSize   ) size
			 pixelsWide:		   (NSInteger) pixelsWide
			 pixelsHigh:		   (NSInteger) pixelsHigh;

	- (NSData *) ICNSRepresentation;

	- (NSImage *) imageTintedWithColor: (NSColor *) tint;

@end

// EOF
