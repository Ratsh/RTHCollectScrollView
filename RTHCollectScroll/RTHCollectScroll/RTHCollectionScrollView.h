//
//  RTHCollectionScrollView.h
//  RTHCollectScroll
//
//  Created by Ratsh on 12.11.14.
//  Copyright (c) 2014 rth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    rthItemShapeRound           = 0,
    rthItemShapeSquare          = 1,
    rthItemShapeCustomRadius    = 2
} RTHItemShape;


@interface RTHCollectionScrollView : UIView<UIScrollViewDelegate>


@property (nonatomic) BOOL              editable;

@property (nonatomic) CGFloat           itemCornerRadius;
@property (nonatomic) CGFloat           itemDistance;
@property (nonatomic) CGFloat           itemSize;
@property (nonatomic) CGFloat           offsetX;
@property (nonatomic) CGFloat           offsetY;

@property (nonatomic) NSUInteger        visibleItems;

@property (nonatomic) RTHItemShape      itemShape;

@property (nonatomic) UIButton          *addButton;

@property (nonatomic) UIImage           *addImage;
@property (nonatomic) UIImage           *delImage;


- (id)initWithItems:(NSArray *)itemsArray;

- (void)addItem:(UIView *)item;
- (void)deleteItemAction:(UIButton *)sender;
- (void)reload;


@end
