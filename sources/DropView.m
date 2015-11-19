/* Foldery - DropView.m
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/\__/\____/\___/__/  \__  /
Copyright © 2014-2015 Betty Lab. /___/
Released under the terms of the GNU General Public License v3. */

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
