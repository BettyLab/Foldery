/* Foldery - DropView.h
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/___/\____/\___/__/ _\__  /
			       /_____/
Copyright © 2014-2015 Manuel Sainz de Baranda y Goñi.
Copyright © 2014-2015 Sofía Ortega Sosa.
Released under the terms of the GNU General Public License v3. */

#import <Cocoa/Cocoa.h>

@protocol DropViewDelegate <NSObject>

	- (void) didReceiveItemPaths: (NSArray *) paths;

@end

@interface DropView : NSView {IBOutlet id <DropViewDelegate> delegate;} @end

// EOF
