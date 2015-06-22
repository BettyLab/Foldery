/* Foldery - RestoreButton.h
 ____      _    _
|  __|___ | | _| | ___  _ _  _ _
|  _|/ _ \| |/ _ |/ ._)| '_|/ | | © 2014-2015 Manuel Sainz de Baranda y Goñi.
|__| \___/|_|\___|\___/|_|  \_. | Released under the terms of the GNU General Public License v3.
			    /__*/

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
