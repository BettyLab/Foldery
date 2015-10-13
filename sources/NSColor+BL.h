/* Betty Lab's Cocoa Extensions - NSColor+BL.m
   ____        ___  ___		  ____	      ___ 
  /  _ ) ____ /  /_/  /_ __ __	 /   / _____ /	/
 /  _  \/  -_)	__/  __/  /  /	/   /_/  _ //  _ \
/______/\___/\__/ \__/ \__  /  /_____/\__,_/_____/
© 2011-2015 Betty Lab. /___/
Released under the terms of the GNU Lesser General Public License v3. */

#import <AppKit/AppKit.h>

@interface NSColor (BL)

	+ (NSColor *) colorFromFloatString: (NSString *) string;

	- (NSString *) floatRGBString;

@end

// EOF
