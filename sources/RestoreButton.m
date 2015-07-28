/* Foldery - RestoreButton.h
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/___/\____/\___/__/ _\__  /
			       /_____/
Copyright © 2014-2015 Manuel Sainz de Baranda y Goñi.
Copyright © 2014-2015 Sofía Ortega Sosa.
Released under the terms of the GNU General Public License v3. */

#import "RestoreButton.h"


@implementation RestoreButton


	- (void) drawRect: (NSRect) frame
		{
		frame = NSInsetRect(frame, 4.0, 4.0);
		NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect: frame];

		[path moveToPoint: NSMakePoint(frame.origin.x + 6.0, frame.origin.y + 6.0)];
		[path lineToPoint: NSMakePoint(frame.origin.x + frame.size.width - 6.0, frame.origin.y + frame.size.height - 6.0)];
		[path moveToPoint: NSMakePoint(frame.origin.x + frame.size.width - 6.0, frame.origin.y + 6.0)];
		[path lineToPoint: NSMakePoint(frame.origin.x + 6.0, frame.origin.y + frame.size.height - 6.0)];
		path.lineWidth = 2.5;
		[[NSColor colorWithCalibratedWhite: 0.0 alpha: 0.15] setStroke];
		[path stroke];
		}


@end

// EOF
