//
//  JTrackViewCell.h
//  JTrackView
//
//  Created by Jeremy Tregunna on 12-04-01.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTrackViewCell : UIView
@property (nonatomic, readonly, copy) NSString* reuseIdentifier;
@property (nonatomic, readonly, strong) UIView* contentView;
@property (unsafe_unretained) NSUInteger index;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString*)reuseIdentifier;

@end
