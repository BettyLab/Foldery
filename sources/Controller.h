/* Foldery - Controller.h
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/___/\____/\___/__/  \__  /
Copyright © 2014-2015 Betty Lab. /___/
Released under the terms of the GNU General Public License v3. */

#import <Cocoa/Cocoa.h>
#import "DropView.h"
#import "NSImage+BL.h"

@interface Controller : NSWindowController <NSApplicationDelegate, NSCollectionViewDelegate, DropViewDelegate> {
	IBOutlet NSImageView*	     previewImageView;
	IBOutlet NSTextField*	     messageTextField;
	IBOutlet NSCollectionView*   colorsCollectionView;
	IBOutlet NSArrayController*  colorsController;
	IBOutlet NSColorWell*	     colorWell;
	IBOutlet NSSegmentedControl* colorActionSegmentedControl;
	IBOutlet NSButton*	     restoreButton;
	IBOutlet NSMenuItem*	     saveMenuItem;

	NSMutableArray* _colors;
	NSImage*	_folderImage;
	NSImage*	_previewImage;
	NSImage*	_tintedImage;
	NSImage*	_baseImage;
	NSColor*	_color;
	NSData*		_ICNS;
	NSUInteger	_draggedColorIndex;
	BOOL		_isInClearMode;
	BOOL		_colorsAreModified;
}
	@property (nonatomic, readonly) NSArray* colors;

	- (IBAction) changeToRestoreMode:  (id) sender;
	- (IBAction) addOrRemoveColorItem: (id) sender;
	- (IBAction) restoreDefaultColors: (id) sender;
@end

// EOF
