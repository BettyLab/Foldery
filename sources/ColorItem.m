/* Foldery - ColorItem.m
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/\__/\____/\___/__/  \__  /
Copyright © 2014-2015 Betty Lab. /___/
Released under the terms of the GNU General Public License v3. */

#import "ColorItem.h"
#import "ColorItemView.h"


@implementation ColorItem


	- (void) setSelected: (BOOL) flag
		{
		[super setSelected: flag];
		[((ColorItemView *)self.view) setSelected: flag];
		}


	- (void) setRepresentedObject: (id) object
		{[(ColorItemView *)self.view setColor: object];}


@end

// EOF
