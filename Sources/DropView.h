/* Foldery - DropView.h
 ____      _    _
|  __|___ | | _| | ___  _ _  _ _
|  _|/ _ \| |/ _ |/ ._)| '_|/ | | © 2014-2015 Manuel Sainz de Baranda y Goñi.
|__| \___/|_|\___|\___/|_|  \_. | Released under the terms of the GNU General Public License v3.
			    /__*/

#import <Cocoa/Cocoa.h>

@protocol DropViewDelegate <NSObject>

	- (void) didReceiveItemPaths: (NSArray *) paths;

@end

@interface DropView : NSView {IBOutlet id <DropViewDelegate> delegate;} @end

// EOF
