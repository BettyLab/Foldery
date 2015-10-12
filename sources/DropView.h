/* Foldery - DropView.h
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/___/\____/\___/__/  \__  /
Copyright © 2014-2015 Betty Lab. /___/
Released under the terms of the GNU General Public License v3. */

#import <Cocoa/Cocoa.h>

@protocol DropViewDelegate <NSObject>

	- (void) didReceiveItemPaths: (NSArray *) paths;

@end

@interface DropView : NSView {IBOutlet id <DropViewDelegate> delegate;} @end

// EOF
