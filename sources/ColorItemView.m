/* Foldery - ColorItemView.m
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/___/\____/\___/__/  \__  /
Copyright © 2014-2015 Betty Lab. /___/
Released under the terms of the GNU General Public License v3. */

#import "ColorItemView.h"


@implementation ColorItemView


	- (void) dealloc
		{
		[_color release];
		[super dealloc];
		}


	- (NSColor *) color {return _color;}


	- (void) setColor: (NSColor *) color
		{
		[_color release];
		_color = [color retain];
		self.needsDisplay = YES;
		}


	- (void) setSelected: (BOOL) flag
		{
		_isSelected = flag;
		self.needsDisplay = YES;
		}


	- (void) drawRect: (NSRect) frame
		{
		NSRect bounds = self.bounds;

		bounds.origin.y += 1.0;

		if (_isSelected)
			{
			[[NSColor lightGrayColor] setStroke];
			[[NSColor colorWithCalibratedWhite: 1.0 alpha: 1.0] setFill];
			[[NSBezierPath bezierPathWithOvalInRect: NSInsetRect(bounds, 1.0, 1.0)] fill];
			[[NSColor colorWithCalibratedWhite: 0.0 alpha: 0.25] setStroke];
			[[NSBezierPath bezierPathWithOvalInRect: NSInsetRect(bounds, 1.5, 1.5)] stroke];
			}

		[NSGraphicsContext saveGraphicsState];
			NSShadow *shadow = [[NSShadow alloc] init];

			[shadow setShadowOffset: NSMakeSize(0.0, -0.5)];
			[shadow setShadowBlurRadius: 1.5];
			[shadow set];
			[_color setFill];
			[[NSBezierPath bezierPathWithOvalInRect: NSInsetRect(bounds, 6.0, 6.0)] fill];
			[shadow release];
		[NSGraphicsContext restoreGraphicsState];

		[[NSColor colorWithCalibratedWhite: 0.0 alpha: 0.1] setStroke];
		[[NSBezierPath bezierPathWithOvalInRect: NSInsetRect(bounds, 6.5, 6.5)] stroke];
		[[NSColor colorWithCalibratedWhite: 1.0 alpha: 0.1] setStroke];
		[[NSBezierPath bezierPathWithOvalInRect: NSInsetRect(bounds, 7.5, 7.5)] stroke];
		}


@end

// EOF
