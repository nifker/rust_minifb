#import "OSXWindowFrameView.h"
#import "OSXWindow.h"

@implementation OSXWindowFrameView

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)updateTrackingAreas
{
    if(trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
        [trackingArea release];
    }

    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                            options:opts
                                            owner:self
                                            userInfo:nil];
    [self addTrackingArea:trackingArea];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)drawRect:(NSRect)rect
{
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];

	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, draw_buffer, width * height * 4, NULL); 

	CGImageRef img = CGImageCreate(width, height, 8, 32, width * 4, space, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little, 
								   provider, NULL, false, kCGRenderingIntentDefault);

	CGColorSpaceRelease(space);
	CGDataProviderRelease(provider);

	CGContextDrawImage(context, CGRectMake(0, 0, width * scale, height * scale), img);

	CGImageRelease(img);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)mouseMoved:(NSEvent *)event
{
    OSXWindow* window = [self window];
    NSRect originalFrame = [window frame];
    NSPoint location = [window mouseLocationOutsideOfEventStream];
    NSRect adjustFrame = [NSWindow contentRectForFrameRect: originalFrame styleMask: NSTitledWindowMask];

    //window->mouse_data->mov

	/*
    printf("%p\n", window->shared_data);

    printf("%f %f - %f %f\n", 
   		adjustFrame.origin.x, 
   		adjustFrame.origin.y, 
   		adjustFrame.size.width, 
   		adjustFrame.size.height);
	
		printf("mouse moved\n");
	*/
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)mouseDown:(NSEvent*)event
{
	printf("mouse down\n");
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)mouseUp:(NSEvent*)event
{
	printf("mouse up\n");
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)rightMouseDown:(NSEvent*)event
{
	printf("right mouseDown up\n");
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)rightMouseUp:(NSEvent*)event
{
	printf("right mouseDown down\n");
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)canBecomeKeyView
{
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)acceptsFirstResponder
{
    return YES;
}

@end

