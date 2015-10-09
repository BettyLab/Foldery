// CocoPlus - NSImage+CocoPlus.m
//   ___	       , __
//  / (_)	      /|/  \ |\
// |	  __   __  __  |___/ | |	__
// |	 / (\_/   / (\_|     |/  |  |  / _\_
//  \___/\__/ \__/\__/ | ___/|__/|_/|_/  \/
// Copyright © 2013-2014 Manuel Sainz de Baranda y Goñi.
// Released under the terms of the GNU Lesser General Public License v3.

#import "NSImage+CocoPlus.h"
#import <QuartzCore/CoreImage.h>

#define kIconFormatCount 10

static const uint16_t iconSizes[]	  = {16, 32, 128, 256, 512, 16, 32, 128, 256,  512};
static const uint16_t iconSizesInPixels[] = {16, 32, 128, 256, 512, 32, 64, 256, 512, 1024};

#if BYTE_ORDER == BIG_ENDIAN

#	define kICNS 'icns'
#	define kTOC  'TOC '

	static const uint32_t iconSignatures[] = {
		'icp4', 'icp5', 'ic07', 'ic08', 'ic09', 'ic11', 'ic12', 'ic13', 'ic14', 'ic10'
	};

#elif BYTE_ORDER == LITTLE_ENDIAN

#	define kICNS 'snci'
#	define kTOC  ' COT'

	static const uint32_t iconSignatures[] = {
		'4pci', '5pci', '70ci', '80ci', '90ci', '11ci', '21ci', '31ci', '41ci', '01ci'
	};

#endif


NS_INLINE NSImageRep *FindRepresentation(
	NSArray*  representations,
	CGFloat	  imageSize,
	NSInteger imageSizeInPixels
)
	{
	for (NSImageRep *representation in representations)
		{
		NSSize size = representation.size;

		if (	imageSize	  == size.width		       &&
			imageSize	  == size.height	       &&
			imageSizeInPixels == representation.pixelsWide &&
			imageSizeInPixels == representation.pixelsHigh
		)
			return representation;
		}

	return nil;
	}


@implementation NSImage (CocoPlus)


	- (NSImageRep *) findRepresentationOfSize: (NSSize   ) size
			 pixelsWide:		   (NSInteger) pixelsWide
			 pixelsHigh:		   (NSInteger) pixelsHigh
		{
		for (NSImageRep *representation in self.representations) if (
			NSEqualSizes(representation.size, size) &&
			pixelsWide == representation.pixelsWide &&
			pixelsHigh == representation.pixelsHigh
		)
			return representation;

		return nil;
		}


	- (NSData *) ICNSRepresentation
		{
		NSArray*	representations = self.representations;
		NSImageRep*	image;
		NSMutableArray* PNGs = [[NSMutableArray alloc] init];
		NSUInteger	formatIndex = 0;
		NSInteger	sizeInPixels;
		CGFloat		size;
		NSColor*	clearColor = [NSColor clearColor];
		uint32_t	TOC[24];
		NSUInteger	TOCIndex = 4;
		uint32_t	fileSize = 16;

		TOC[0] = kICNS;
		TOC[2] = kTOC;

		for (; formatIndex < kIconFormatCount; formatIndex++) if ((
			image = FindRepresentation
				(representations,
				 size = (CGFloat)iconSizes[formatIndex],
				 sizeInPixels = (NSUInteger)iconSizesInPixels[formatIndex])
		))
			{
			NSRect frame = NSMakeRect(0.0, 0.0, sizeInPixels, sizeInPixels);

			NSBitmapImageRep* bitmap = [[NSBitmapImageRep alloc]
				initWithBitmapDataPlanes: NULL
				pixelsWide:		  sizeInPixels
				pixelsHigh:		  sizeInPixels
				bitsPerSample:		  8
				samplesPerPixel:	  4
				hasAlpha:		  YES
				isPlanar:		  NO
				colorSpaceName:		  NSCalibratedRGBColorSpace
				bytesPerRow:		  4 * sizeInPixels
				bitsPerPixel:		  32];

			NSGraphicsContext *graphicsContext = [NSGraphicsContext graphicsContextWithBitmapImageRep: bitmap];
			[bitmap release];

			[NSGraphicsContext saveGraphicsState];

				[NSGraphicsContext setCurrentContext: graphicsContext];
				[clearColor setFill];
				NSRectFill(frame);

				[image	drawInRect:	frame
					fromRect:	NSZeroRect
					operation:	NSCompositeSourceOver
					fraction:	1.0
					respectFlipped: YES
					hints:		nil];

				bitmap.size = NSMakeSize(size, size);

				NSData *PNG = [bitmap representationUsingType: NSPNGFileType properties: @{}];

			[NSGraphicsContext restoreGraphicsState];

			uint32_t PNGSize = (uint32_t)PNG.length;

			TOC[TOCIndex] = iconSignatures[formatIndex];
			TOC[TOCIndex + 1] = CFSwapInt32HostToBig((uint32_t)(PNG.length + 8));
			fileSize += 16 + PNGSize;
			[PNGs addObject: PNG];
			TOCIndex += 2;
			}

		if (TOCIndex == 4)
			{
			[PNGs release];
			return nil;
			}

		TOC[1] = CFSwapInt32HostToBig(fileSize);
		TOC[3] = CFSwapInt32HostToBig((uint32_t)((TOCIndex - 2) * 4));

		NSMutableData *result = [[[NSMutableData alloc] init] autorelease];
		NSUInteger bodyOffset = TOCIndex * 4;

		[result setLength: fileSize];
		[result replaceBytesInRange: NSMakeRange(0, bodyOffset) withBytes: TOC];
		TOCIndex = 4;

		for (NSData *PNG in PNGs)
			{
			NSUInteger length = PNG.length;

			[result replaceBytesInRange: NSMakeRange(bodyOffset, 8) withBytes: &TOC[TOCIndex]];
			[result replaceBytesInRange: NSMakeRange(bodyOffset + 8, length) withBytes: PNG.bytes];
			TOCIndex += 2;
			bodyOffset += length + 8;
			}

		[PNGs release];

		return result;
		}


- (NSImage *) imageTintedWithColor: (NSColor *) tint
	{
	NSSize size = [self size];
	NSRect bounds = {NSZeroPoint, size};
	CGFloat tintComponents[4];

	tint = [tint colorUsingColorSpaceName: NSCalibratedRGBColorSpace];

	NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc]
		initWithBitmapDataPlanes: NULL
		pixelsWide:		  (NSInteger)size.width
		pixelsHigh:		  (NSInteger)size.height
		bitsPerSample:		  8
		samplesPerPixel:	  4
		hasAlpha:		  YES
		isPlanar:		  NO
		colorSpaceName:		  NSCalibratedRGBColorSpace
		bytesPerRow:		  (NSInteger)size.width * 4
		bitsPerPixel:		  32];

	NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithBitmapImageRep: bitmap];

	[bitmap release];

	[NSGraphicsContext saveGraphicsState];
		[NSGraphicsContext setCurrentContext: context];

		CIFilter *filter = [CIFilter filterWithName: @"CIColorMonochrome"];

		[filter setDefaults];
		[filter setValue: [CIImage imageWithData: [self TIFFRepresentation]] forKey: @"inputImage"];
		[tint getComponents: tintComponents];

		[filter setValue: [CIColor
				colorWithRed: tintComponents[0]
				green:	      tintComponents[1]
				blue:	      tintComponents[2]
				alpha:	      1.0]
			forKey: @"inputColor"];

		[filter setValue: [NSNumber numberWithFloat: 1] forKey: @"inputIntensity"];

		[[filter valueForKey:@"outputImage"]
			drawAtPoint: NSZeroPoint
			fromRect:    bounds
			operation:   NSCompositeCopy
			fraction:    1.0];

		NSImage *tintedImage = [[NSImage alloc] init];

		[tintedImage addRepresentation: bitmap];
	[NSGraphicsContext restoreGraphicsState];

	return [tintedImage autorelease];
	}

/*
- (NSImage*) imageCroppedToRect:(NSRect)rect
	{
	NSPoint point = { -rect.origin.x, -rect.origin.y };
	NSImage *croppedImage = [[NSImage alloc] initWithSize: rect.size];

	[croppedImage lockFocus];
		[self compositeToPoint: point operation: NSCompositeCopy];
	[croppedImage unlockFocus];

	return [croppedImage autorelease];
	}*/


@end

// EOF
