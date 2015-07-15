/* Foldery - ColorItemView.h
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/___/\____/\___/__/ _\__  /
			       /_____/
Copyright © 2014-2015 Manuel Sainz de Baranda y Goñi.
Copyright © 2014-2015 Sofía Ortega Sosa.
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
