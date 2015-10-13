/* Betty Lab's Cocoa Extensions - NSColor+BL.m
   ____        ___  ___		  ____	      ___ 
  /  _ ) ____ /  /_/  /_ __ __	 /   / _____ /	/
 /  _  \/  -_)	__/  __/  /  /	/   /_/  _ //  _ \
/______/\___/\__/ \__/ \__  /  /_____/\__,_/_____/
© 2011-2015 Betty Lab. /___/
Released under the terms of the GNU Lesser General Public License v3. */

#import "NSColor+BL.h"


@implementation NSColor (BL)


	+ (NSColor *) colorFromFloatString: (NSString *) string
		{
		if (string && [string isKindOfClass: [NSString class]])
			{
			NSArray *channels = [string componentsSeparatedByString: @":"];

			CGFloat components[4] = {
				[[channels objectAtIndex: 0] doubleValue],
				[[channels objectAtIndex: 1] doubleValue],
				[[channels objectAtIndex: 2] doubleValue],
				[channels count] == 3 ? 1.0 : [[channels objectAtIndex: 3] doubleValue]
			};

			return [NSColor
				colorWithColorSpace: [NSColorSpace sRGBColorSpace]
				components:	     components
				count:		     4];
			}

		return nil;
		}


	- (NSString *) floatRGBString
		{
		NSInteger componentCount = self.numberOfComponents;

		if (componentCount == 3 || componentCount == 4)
			{
			CGFloat components[4];

			[self getComponents: components];

			return [NSString stringWithFormat:
				@"%f:%f:%f",
				components[0],
				components[1],
				components[2]];
			}

		return [NSString stringWithFormat:
			@"%f:%f:%f",
			self.redComponent,
			self.greenComponent,
			self.blueComponent];
		}


@end

// EOF
