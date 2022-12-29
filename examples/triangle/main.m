// based on the Metal sample "Using a Render Pipeline to Render Primitives"
// along with https://www.cocoawithlove.com/2010/09/minimalist-cocoa-programming.html
// to create a basic window programmatically

#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <AppKit/AppKit.h>

#import "Renderer/AAPLRenderer.h"

int main(int argc, char** argv) {
	[NSAutoreleasePool new];
	[NSApplication sharedApplication];
	[NSApp setActivationPolicy: NSApplicationActivationPolicyRegular];

	NSMenu* menubar = [[NSMenu new] autorelease];
	NSMenuItem* appMenuItem = [[NSMenuItem new] autorelease];

	[menubar addItem: appMenuItem];
	[NSApp setMainMenu: menubar];

	NSMenu* appMenu = [[NSMenu new] autorelease];
	NSString* appName = [[NSProcessInfo processInfo] processName];
	NSString* quitTitle = [@"Quit " stringByAppendingString: appName];
	NSMenuItem* quitMenuItem = [[[NSMenuItem alloc] initWithTitle: quitTitle action: @selector(terminate:) keyEquivalent: @"q"] autorelease];

	[appMenu addItem: quitMenuItem];
	[appMenuItem setSubmenu: appMenu];

	NSWindow* window = [[[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 800, 600) styleMask: NSWindowStyleMaskTitled backing: NSBackingStoreBuffered defer: NO] autorelease];

	[window cascadeTopLeftFromPoint: NSMakePoint(20, 20)];
	[window setTitle: appName];
	[window makeKeyAndOrderFront: nil];
	//[NSApp activateIgnoringOtherApps: YES];

	window.styleMask |= NSWindowStyleMaskResizable;

	id<MTLDevice> device = [MTLCreateSystemDefaultDevice() autorelease];
	MTKView* view = [[[MTKView alloc] initWithFrame: NSMakeRect(0, 0, 800, 600) device: device] autorelease];
	AAPLRenderer* renderer = [[[AAPLRenderer alloc] initWithMetalKitView: view] autorelease];

	// initialize the view size
	[renderer mtkView: view drawableSizeWillChange: view.drawableSize];

	view.delegate = renderer;

	window.contentView = view;

	[NSApp run];

	return 0;
};
