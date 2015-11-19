/* Foldery - Controller.m
   _______     ___    ___
  /   ___/__  /  /___/	/___ _______ ___
 /   __/  _ \/	//  _  /  -_)  __/  /  /
/___/  \____/\__/\____/\___/__/  \__  /
Copyright © 2014-2015 Betty Lab. /___/
Released under the terms of the GNU General Public License v3. */

#import "Controller.h"
#import "ColorItem.h"
#import "NSColor+BL.h"


@implementation Controller


#	pragma mark - Helpers


	- (void) generateTintedImageAndICNS
		{
		[_tintedImage release];
		[_ICNS	      release];

		NSImage *tintedImage = [[NSImage alloc] init], *image;
		NSImageRep *tintedRepresentation;

		for (NSImageRep *representation in _folderImage.representations)
			{
			image = [[NSImage alloc] initWithSize: NSMakeSize(representation.pixelsWide, representation.pixelsHigh)];
			[image addRepresentation: representation];
			tintedRepresentation = [image imageTintedWithColor: _color].representations[0];
			tintedRepresentation.size = representation.size;
			[tintedImage addRepresentation: tintedRepresentation];
			[image release];
			}

		_tintedImage = [[NSImage alloc] initWithData: _ICNS = [[tintedImage ICNSRepresentation] retain]];
		[tintedImage release];
		}


	- (void) setCurrentColor: (NSColor *) color
		{
		[_color	      release]; _color	     = [color retain];
		[_ICNS	      release]; _ICNS	     = nil;
		[_tintedImage release]; _tintedImage = nil;

		@autoreleasepool
			{previewImageView.image = [_previewImage imageTintedWithColor: _color];}
		}


	- (void) loadColors
		{
		[_colors removeAllObjects];

		for (NSString *colorString in [[NSUserDefaults standardUserDefaults] objectForKey: @"Colors"])
			[_colors addObject: [NSColor colorFromFloatString: colorString]];
		}


#	pragma mark - Callbacks


	- (void) observeValueForKeyPath: (NSString     *) keyPath
		 ofObject:		 (id		) object
		 change:		 (NSDictionary *) change
		 context:		 (void	       *) context
		{
		NSIndexSet *indexes = colorsCollectionView.selectionIndexes;

		if (indexes.count)
			{
			id color = _colors[indexes.firstIndex];

			_isInClearMode = NO;
			restoreButton.hidden = NO;
			messageTextField.stringValue = _("Tint");
			[saveMenuItem setEnabled: YES];
			[colorActionSegmentedControl setEnabled: YES forSegment: 1];
			[colorWell setHidden: NO];
			[self setCurrentColor: color];
			colorWell.color = color;
			}

		else	{
			_isInClearMode = YES;
			restoreButton.hidden = YES;
			messageTextField.stringValue = _("Restore");
			[saveMenuItem setEnabled: NO];
			[colorActionSegmentedControl setEnabled: NO forSegment: 1];
			[colorWell setHidden: YES];
			previewImageView.image = _previewImage;
			//colorWell.color = [NSColor whiteColor];
			}
		}


#	pragma mark - Accessors


	@synthesize colors = _colors;


#	pragma mark - NSApplicationDelegate Protocol


	- (void) applicationWillFinishLaunching: (NSNotification *) notification
		{
		[[NSUserDefaults standardUserDefaults] registerDefaults: @{@"Colors":
			@[@"1.000000:0.555097:0.574395",
			  @"1.000000:0.759421:0.506289",
			  @"0.997751:0.888160:0.482202",
			  @"0.608094:0.924266:0.511184",
			  @"0.473722:0.775254:0.998977",
			  @"0.924200:0.670990:0.999455",
			  @"0.727273:0.727273:0.727273",
			  @"0.976471:0.282353:0.278431",
			  @"0.964706:0.588235:0.152941",
			  @"0.976471:0.800000:0.152941",
			  @"0.423529:0.823529:0.286275",
			  @"0.215686:0.611765:0.870588",
			  @"0.796078:0.462745:0.882353",
			  @"0.541176:0.541176:0.552941",
			  @"0.985942:0.000000:0.064866",
			  @"0.989765:0.455282:0.032296",
			  @"0.993550:0.683299:0.035511",
			  @"0.191326:0.887153:0.019900",
			  @"0.041693:0.380318:0.998361",
			  @"0.724125:0.000000:0.998729",
			  @"0.330000:0.330000:0.330000"]}];

		_isInClearMode = YES;
		_folderImage   = [[[NSWorkspace sharedWorkspace] iconForFileType: NSFileTypeForHFSTypeCode(kGenericFolderIcon)] retain];
		_previewImage  = [[NSImage alloc] initWithSize: NSMakeSize(128.0, 128.0)];
		_colors	       = [[NSMutableArray alloc] init];

		[NSBundle loadNibNamed: @"Window" owner: self];

		NSWindow *window = self.window;

		if ([window respondsToSelector: @selector(backingScaleFactor)] && window.backingScaleFactor > 1.0)
			{
			[_previewImage addRepresentation: [_folderImage
				findRepresentationOfSize: NSMakeSize(128.0, 128.0)
				pixelsWide:		  256
				pixelsHigh:		  256]];

			_previewImage.size = NSMakeSize(256.0, 256.0);
			}

		else [_previewImage addRepresentation: [_folderImage
			findRepresentationOfSize: NSMakeSize(128.0, 128.0)
			pixelsWide:		  128
			pixelsHigh:		  128]];

		previewImageView.image = _previewImage;
		messageTextField.stringValue = _("Restore");

		[colorsCollectionView setValue: @(0) forKey: @"_animationDuration"];
		[self loadColors];
		[colorsCollectionView registerForDraggedTypes: @[NSColorPboardType]];
		[colorsCollectionView setDraggingSourceOperationMask: NSDragOperationMove forLocal: YES];
		[colorsCollectionView setDraggingSourceOperationMask: NSDragOperationCopy forLocal: NO];
		colorsController.content = _colors;
		[colorsCollectionView addObserver: self forKeyPath: @"selectionIndexes" options: 0 context: nil];
		}


	- (void) applicationDidFinishLaunching: (NSNotification *) notification
		{[self.window makeKeyAndOrderFront: self];}


	- (void) applicationWillTerminate: (NSNotification *) notification
		{
		[colorsCollectionView removeObserver: self forKeyPath: @"selectionIndexes"];

		if (_colorsAreModified)
			{
			NSMutableArray *colors = [[NSMutableArray alloc] init];

			for (NSColor *color in _colors)
				[colors addObject: [color floatRGBString]];

			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

			[defaults setObject: colors forKey: @"Colors"];
			[defaults synchronize];
			[colors release];
			}

		[_folderImage  release];
		[_previewImage release];
		[_tintedImage  release];
		[_ICNS	       release];
		[_color	       release];
		[_colors       release];
		}


	- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) sender
		{return YES;}


#	pragma mark - NSCollectionViewDelegate Protocol


	- (BOOL) collectionView:	(NSCollectionView *) collectionView
		 canDragItemsAtIndexes: (NSIndexSet	  *) indexes
		 withEvent:		(NSEvent	  *) event
		{
		_draggedColorIndex = indexes.firstIndex;
		return YES;
		}


	- (BOOL) collectionView:      (NSCollectionView *) collectionView
		 writeItemsAtIndexes: (NSIndexSet	*) indexes
		 toPasteboard:	      (NSPasteboard	*) pasteboard
		{
		[pasteboard writeObjects: @[_colors[indexes.firstIndex]]];
		return YES;
		}


	- (BOOL) collectionView: (NSCollectionView	      *) collectionView
		 acceptDrop:	 (id <NSDraggingInfo>	       ) draggingInfo
		 index:		 (NSInteger		       ) index
		 dropOperation:	 (NSCollectionViewDropOperation) dropOperation
		{
		if ([draggingInfo draggingSource] != colorsCollectionView)
			{
			[colorsController
				insertObject:	       [NSColor colorFromPasteboard: [draggingInfo draggingPasteboard]]
				atArrangedObjectIndex: index];

			_colorsAreModified = YES;
			return YES;
			}

		else if	(index != _draggedColorIndex)
			{
			if (index > _draggedColorIndex) index--;
			[colorsCollectionView setAnimations: @{}];
			NSColor *color = [_colors[_draggedColorIndex] retain];

			[colorsController removeObjectAtArrangedObjectIndex: _draggedColorIndex];
			[colorsController insertObject: color atArrangedObjectIndex: index];
			[color release];
			_colorsAreModified = YES;
			return YES;
			}

		return NO;
		}


	- (NSDragOperation) collectionView: (NSCollectionView		   *) collectionView
			    validateDrop:   (id <NSDraggingInfo>	    ) draggingInfo
			    proposedIndex:  (NSInteger			   *) proposedDropIndex
			    dropOperation:  (NSCollectionViewDropOperation *) proposedDropOperation
		{
		*proposedDropOperation = NSCollectionViewDropBefore;
		return NSDragOperationMove;
		}


#	pragma mark - DropViewDelegate Protocol


	- (void) didReceiveItemPaths: (NSArray *) paths
		{
		NSWorkspace *workspace = [NSWorkspace sharedWorkspace];

		if (_isInClearMode) for (NSString *path in paths)
			[workspace setIcon: nil forFile: path options: 0];

		else	{
			if (!_tintedImage) [self generateTintedImageAndICNS];

			NSFileManager *fileManager = [NSFileManager defaultManager];

			for (NSString *path in paths)
				{
				BOOL isDirectory = NO;
				NSString *itemType;

				[fileManager fileExistsAtPath: path isDirectory: &isDirectory];

				if (isDirectory || ((itemType = NSHFSTypeOfFile(path)) && [itemType isEqualToString: @"'fdrp'"]))
					{
					[workspace setIcon: nil		 forFile: path options: 0];
					[workspace setIcon: _tintedImage forFile: path options: 0];
					}
				}
			}
		}


#	pragma mark - IBAction


	- (IBAction) saveDocument: (id) sender
		{
		if (!_ICNS) [self generateTintedImageAndICNS];

		NSSavePanel *panel = [NSSavePanel savePanel];

		panel.allowedFileTypes = @[@"icns"];
		panel.canSelectHiddenExtension = YES;
		panel.nameFieldStringValue = _("MyIcon");

		[panel beginSheetModalForWindow: self.window completionHandler: ^(NSInteger result)
			{
			if (result == NSFileHandlingPanelOKButton)
				{
				NSError *error;

				if (![_ICNS writeToURL: panel.URL options: NSDataWritingAtomic error: &error])
					[[NSAlert alertWithError: error] runModal];
				}
			}];
		}


	- (IBAction) changeColor: (NSColorWell *) sender
		{
		if (!_isInClearMode)
			{
			NSColor*   color = [sender.color colorUsingColorSpace: [NSColorSpace sRGBColorSpace]];;
			NSUInteger index = colorsCollectionView.selectionIndexes.firstIndex;
			ColorItem* item  = (ColorItem *)[colorsCollectionView itemAtIndex: index];

			[item setRepresentedObject: color];
			[_colors replaceObjectAtIndex: index withObject: color];
			[self setCurrentColor: color];
			_colorsAreModified = YES;
			}
		}


	- (IBAction) changeToRestoreMode: (id) sender
		{[colorsCollectionView setSelectionIndexes: [NSIndexSet indexSet]];}


	- (IBAction) addOrRemoveColorItem: (NSSegmentedControl *) sender
		{
		if (sender.selectedSegment)
			{
			colorsController.avoidsEmptySelection = YES;
			[colorsController removeObjectsAtArrangedObjectIndexes: colorsCollectionView.selectionIndexes];
			colorsController.avoidsEmptySelection = NO;
			}

		else	{
			NSUInteger index = colorsController.selectionIndexes.firstIndex;

			[colorsController addObject: index != NSNotFound
				? _colors[index]
				: (_colors.count ? _colors.lastObject : [NSColor redColor])];
			}

		_colorsAreModified = YES;
		}


	- (IBAction) restoreDefaultColors: (id) sender
		{
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

		[defaults removeObjectForKey: @"Colors"];
		[defaults synchronize];
		colorsController.preservesSelection = NO;
		[self loadColors];
		colorsController.content = nil;
		colorsController.content = _colors;
		_colorsAreModified = NO;
		colorsController.preservesSelection = YES;
		}


@end

// EOF
