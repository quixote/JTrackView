# JTrackView
Copyright © 2012, Jeremy Tregunna, All Rights Reserved.

## Overview

JTrackView is a UI component similar in nature to a UITableView which allows for scrolling a list of items in a horizontal manner rather than a vertical manner such as with a UITableView. It is intended to be very lightweight, and performance has been measured on an iPhone 4 at a worst case of 55 fps with a non-trivial set of opaque subviews. In other words, it scrolls like butter.

## Using

To use JTrackView, add these files to your project, ensure the `JTrackView.m` and `JTrackViewCell.m` files are in your compile build phase.

In your view controller, add a reference to the trackView, connect it to a `UIScrollView` in a nib or storyboard (remembering to change the class name to JTrackView) as an outlet (should you choose to do it this way), or create it manually by calling `-initWithFrame:`. Set the data source on the trackview to your controller, and implement `JTrackViewDelegate` however you need to.

For instance, your implementation may look like this:

```objc
@interface FantasticViewController : UIViewController
@property (nonatomic, strong) IBOutlet JTrackView* trackView;
@end

@implementation FantasticViewController

@synthesize trackView = _trackView;

/* ... */

- (void)numberOfPagesInTrackView:(JTrackView*)trackView
{
    return 5;
}

- (CGFloat)pageWidthInTrackView:(JTrackView*)trackView;
{
    return CGRectGetWidth(self.trackView.bounds);
}

- (JTrackViewCell*)trackView:(JTrackView*)trackView cellForPageAtIndex:(NSUInteger)index
{
    static NSString* identifier = @"TrackCell";
    // When you dequeue a cell, you will always, always get back a good object you can use,
    // even if there are no cells for recycling available, we'll create one for you.
    JTrackViewCell* cell = [trackView dequeueReusableCellWithIdentifier:identifier];

    /* do your stuff */

    return cell;
}

/* ... */

@end
```

You should now have 5 pages of cells.

## License

Copyright © 2012, Jeremy Tregunna, All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
