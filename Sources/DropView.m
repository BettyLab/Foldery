/* Foldery - DropView.m
 ____      _    _
|  __|___ | | _| | ___  _ _  _ _
|  _|/ _ \| |/ _ |/ ._)| '_|/ | | © 2014-2015 Manuel Sainz de Baranda y Goñi.
|__| \___/|_|\___|\___/|_|  \_. | Released under the terms of the GNU General Public License v3.
			    /__*/

#import "DropView.h"


@implementation DropView


	- (id) initWithFrame: (NSRect) frame
		{
		if ((self = [super initWithFrame: frame]))
			[self registerForDraggedTypes: @[NSFilenamesPboardType]];

		return self;
		}


	- (NSDragOperation) draggingEntered: (id <NSDraggingInfo>) sender
		{
		if ([[[sender draggingPasteboard] types] containsObject: NSFilenamesPboardType])
			return NSDragOperationCopy;

		return NSDragOperationNone;
		}


	- (BOOL) performDragOperation: (id <NSDraggingInfo>) sender
		{
		NSPasteboard *pasteboard = [sender draggingPasteboard];

		if ([[pasteboard types] containsObject: NSFilenamesPboardType])
			[delegate didReceiveItemPaths: [pasteboard propertyListForType: NSFilenamesPboardType]];

		return YES;
		}


	- (BOOL) mouseDownCanMoveWindow {return YES;}

@end

// EOF
