/* Foldery - Controller.h
 ____      _    _
|  __|___ | | _| | ___  _ _  _ _
|  _|/ _ \| |/ _ |/ ._)| '_|/ | | © 2014-2015 Manuel Sainz de Baranda y Goñi.
|__| \___/|_|\___|\___/|_|  \_. | Released under the terms of the GNU General Public License v3.
			    /__*/

#import <Cocoa/Cocoa.h>
#import "DropView.h"
#import "NSImage+CocoPlus.h"

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
