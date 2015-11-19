/* Foldery - ColorItemView.h
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/\__/\____/\___/__/  \__  /
Copyright © 2014-2015 Betty Lab. /___/
Released under the terms of the GNU General Public License v3. */

#import <Cocoa/Cocoa.h>

@interface ColorItemView : NSView {

	NSColor* _color;
	BOOL	 _isSelected;
}
	@property (nonatomic, retain) NSColor *color;

	- (void) setSelected: (BOOL) selected;

@end

// EOF
