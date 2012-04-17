//
//  JTrackView.m
//  JTrackView
//
//  Created by Jeremy Tregunna on 12-04-01.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import "JTrackView.h"
#import "JTrackViewCell.h"

@interface JTrackView ()
@property (nonatomic, strong) NSMutableSet* recycledCells;
@property (nonatomic, strong) NSMutableSet* visibleCells;
- (void)commonInitialization;
@end

@implementation JTrackView

@synthesize dataSource, pageControl;
@synthesize recycledCells, visibleCells;

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
        [self commonInitialization];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
        [self commonInitialization];
    return self;
}

- (void)commonInitialization
{
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.alwaysBounceVertical = NO;
    self.directionalLockEnabled = YES;
    self.recycledCells = [[NSMutableSet alloc] init];
    self.visibleCells = [[NSMutableSet alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emptyRecycledCells)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Dealing with reusable cells

- (CGRect)frameForCellAtIndex:(NSUInteger)index
{
    return CGRectMake(index * CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (BOOL)isDisplayingCellAtIndex:(NSUInteger)index
{
    __block BOOL foundCell = NO;
    
    [self.visibleCells enumerateObjectsUsingBlock:^(JTrackViewCell* cell, BOOL *stop) {
        if(cell.index == index)
        {
            foundCell = YES;
            *stop = YES;
        }
    }];
    
    return foundCell;
}

- (JTrackViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier
{
    NSSet* filteredSet = [self.recycledCells filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"reuseIdentifier == %@", identifier]];
    JTrackViewCell* cell = [filteredSet anyObject];
    if(cell == nil)
    {
        // All cells must have the same height.
        CGRect cellFrame = [self frameForCellAtIndex:0];
        // Create a new cell if we don't have one. Save the caller from doing it.
        cell = [[JTrackViewCell alloc] initWithFrame:cellFrame];
    }
    else
        [self.recycledCells removeObject:cell];
    
    return cell;
}

- (void)layoutCells
{
    // Calculate which pages are visible
    CGRect visibleBounds = self.bounds;
    int numberOfPages = 0;
    if([self.dataSource respondsToSelector:@selector(numberOfPagesInTrackView:)])
        numberOfPages = [self.dataSource numberOfPagesInTrackView:self];
    int firstPageIndex = MAX(floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds)), 0);
    int lastPageIndex  = MIN(floorf((CGRectGetMaxX(visibleBounds) - 1) / CGRectGetWidth(visibleBounds)), numberOfPages - 1);
    
    // Recycle no-longer-visible pages 
    for(JTrackViewCell* cell in self.visibleCells)
    {
        if(cell.index < firstPageIndex || cell.index > lastPageIndex)
        {
            [self.recycledCells addObject:cell];
            [cell removeFromSuperview];
        }
    }
    [self.visibleCells minusSet:self.recycledCells];
    
    // add missing cells
    for(int index = firstPageIndex; index <= lastPageIndex; index++)
    {
        if(![self isDisplayingCellAtIndex:index] && [self.dataSource respondsToSelector:@selector(trackView:cellForPageAtIndex:)])
        {
            JTrackViewCell* cell = [self.dataSource trackView:self cellForPageAtIndex:index];
            cell.frame = [self frameForCellAtIndex:index];
            cell.index = index;
            [self addSubview:cell];
            [self.visibleCells addObject:cell];
        }
    }
}

#pragma mark - Low memory conditions

- (void)emptyRecycledCells
{
    [self.recycledCells removeAllObjects];
}

@end
