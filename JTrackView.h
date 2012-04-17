//
//  JTrackView.h
//  JTrackView
//
//  Created by Jeremy Tregunna on 12-04-01.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JTrackView, JTrackViewCell;

@protocol UCTrackViewDataSource
- (NSUInteger)numberOfPagesInTrackView:(JTrackView*)trackView;
- (CGFloat)pageWidthInTrackView:(JTrackView*)trackView;
- (JTrackViewCell*)trackView:(JTrackView*)trackView cellForPageAtIndex:(NSUInteger)index;
@end

@interface JTrackView : UIScrollView
@property (nonatomic, weak) id<UCTrackViewDataSource> dataSource;
@property (nonatomic, strong) UIPageControl* pageControl;

- (JTrackViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier;
- (CGRect)frameForCellAtIndex:(NSUInteger)index;
- (void)layoutCells;

@end
