/* Foldery - ColorItemView.h
 ____      _    _
|  __|___ | | _| | ___  _ _  _ _
|  _|/ _ \| |/ _ |/ ._)| '_|/ | | © 2014-2015 Manuel Sainz de Baranda y Goñi.
|__| \___/|_|\___|\___/|_|  \_. | Released under the terms of the GNU General Public License v3.
			    /__*/

#import <Cocoa/Cocoa.h>

@interface ColorItemView : NSView {

	NSColor* _color;
	BOOL	 _isSelected;
}
	@property (nonatomic, retain) NSColor *color;

	- (void) setSelected: (BOOL) selected;

@end

// EOF
