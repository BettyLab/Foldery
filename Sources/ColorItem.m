/* Foldery - ColorItem.m
 ____      _    _
|  __|___ | | _| | ___  _ _  _ _
|  _|/ _ \| |/ _ |/ ._)| '_|/ | | © 2014-2015 Manuel Sainz de Baranda y Goñi.
|__| \___/|_|\___|\___/|_|  \_. | Released under the terms of the GNU General Public License v3.
			    /__*/

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
