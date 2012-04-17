//
//  JTrackViewCell.m
//  JTrackView
//
//  Created by Jeremy Tregunna on 12-04-01.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import "JTrackViewCell.h"

@interface JTrackViewCell ()
@property (nonatomic, readwrite, copy) NSString* reuseIdentifier;
@end

@implementation JTrackViewCell

@synthesize reuseIdentifier, index;
@synthesize contentView = _contentView;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString*)identifier;
{
    if((self = [super initWithFrame:frame]))
        self.reuseIdentifier = identifier;
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (UIView*)contentView
{
    if(_contentView == nil)
    {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _contentView.autoresizesSubviews = YES;
        _contentView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:_contentView];
        self.autoresizesSubviews = YES;
    }
    
    return _contentView;
}

@end
