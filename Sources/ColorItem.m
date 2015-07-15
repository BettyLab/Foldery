/* Foldery - ColorItem.m
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/___/\____/\___/__/ _\__  /
			       /_____/
Copyright © 2014-2015 Manuel Sainz de Baranda y Goñi.
Copyright © 2014-2015 Sofía Ortega Sosa.
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
