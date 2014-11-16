//
//  RTHCollectionScrollView.m
//  RTHCollectScroll
//
//  Created by Ratsh on 12.11.14.
//  Copyright (c) 2014 rth. All rights reserved.
//

#import "RTHCollectionScrollView.h"

@implementation RTHCollectionScrollView {
    BOOL            addingItem;
    BOOL            isDeleteMode;
    
    CGFloat         resizeItemDelta;
    
    NSMutableArray  *items;
    
    UIScrollView    *scrollView;
}

- (id)init {
    self = [super init];
    
    if (self) {
        items                                   = @[].mutableCopy;
        [self defaultInit];
    }
    
    return self;
}

- (id)initWithItems:(NSArray *)itemsArray {
    self = [super init];
    
    if (self) {
        items = itemsArray.mutableCopy;
        [self defaultInit];
    }
    
    return self;
}

- (void)layoutSubviews {
    CGSize  scrollSize                          = scrollView.contentSize;
    CGSize  selfSize                            = self.bounds.size;
    CGFloat x;
    BOOL    scrollLessSelf                      = NO;
    
    selfSize.height                             = scrollSize.height;
    selfSize.width                              = _visibleItems * (_itemDistance + _itemSize);
    
    if (selfSize.width > scrollSize.width) {
        scrollLessSelf                          = YES;
        x                                       = (selfSize.width - scrollSize.width) / 2;
    } else {
        x                                       = 0.0;
    }
    
    scrollView.frame                            = CGRectMake(x, 0.0, selfSize.width, selfSize.height);
    self.frame                                  = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                                             selfSize.width, selfSize.height);
    
    if (addingItem && !scrollLessSelf) {
        CGFloat     rightLimit                  = scrollView.contentSize.width -
                                                    scrollView.frame.size.width;
        
        addingItem                              = NO;
        [scrollView setContentOffset:CGPointMake(rightLimit, 0.0)
                            animated:YES];
    } else {
        [self normilizeOffsetOfScrollView:scrollView];
    }
}

- (void)addItem:(UIView *)item {
    if (_editable) {
        CGFloat     itemTotalWidth              = _itemSize + _itemDistance;
        CGRect      tmpFrame                    = _addButton.frame;
        
        [items insertObject:item atIndex:items.count - 1];
        
        item.layer.cornerRadius                 = _itemCornerRadius;
        item.frame                              = tmpFrame;
        [scrollView addSubview:item];
        
        tmpFrame.origin.x                      += itemTotalWidth;
        _addButton.frame                        = tmpFrame;
        
        scrollView.contentSize                  = CGSizeMake(2 * _offsetX + items.count * itemTotalWidth - _itemDistance,
                                                             2 * _offsetY + _itemSize);
        addingItem                              = YES;
        [self setNeedsLayout];
    }
}

- (void)defaultInit {
    _editable                                   = NO;
    _itemCornerRadius                           = 5.0;
    _itemDistance                               = 5.0;
    _itemShape                                  = rthItemShapeRound;
    _itemSize                                   = 10.0;
    _offsetX                                    = 10.0;
    _offsetY                                    = 5.0;
    _visibleItems                               = 3;
    
    addingItem                                  = NO;
    isDeleteMode                                = NO;
    resizeItemDelta                             = 2.0;
    
    scrollView                                  = [UIScrollView new];
    scrollView.backgroundColor                  = [UIColor clearColor];
    scrollView.bounces                          = NO;
    scrollView.delegate                         = self;
    scrollView.showsHorizontalScrollIndicator   = NO;
    scrollView.showsVerticalScrollIndicator     = NO;
    [self addSubview:scrollView];
    
    UILongPressGestureRecognizer *longPressGesture =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(gestureHandler:)];
    longPressGesture.minimumPressDuration       = 2.0;
    [self addGestureRecognizer:longPressGesture];
    
    [self fillScroll];
}

- (void)fillScroll {
    CGFloat         itemTotalWidth              = _itemSize + _itemDistance;
    NSInteger       lastItem                    = items.count;
    
    if (scrollView.subviews.count > 0) {
        for (UIView *view in scrollView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    if (_editable) {
        lastItem                               -= 1;
    }
    for (int i = 0; i < lastItem; i++) {
        CGFloat     x                           = _offsetX + i * itemTotalWidth;
        UIView      *item                       = items[i];
        
        item.clipsToBounds                      = YES;
        item.frame                              = CGRectMake(x, _offsetY, _itemSize, _itemSize);
        item.layer.cornerRadius                 = _itemCornerRadius;
        [scrollView addSubview:item];
    }
    
    if ([items indexOfObject:_addButton] != NSNotFound) {
        [scrollView addSubview:_addButton];
    }
    _addButton.frame                            = CGRectMake(_offsetX + lastItem * itemTotalWidth, _offsetY,
                                                             _itemSize, _itemSize);
    
    scrollView.contentSize                      = CGSizeMake(2 * _offsetX + items.count * itemTotalWidth - _itemDistance,
                                                             2 * _offsetY + _itemSize);
    
    if (isDeleteMode) {
        [self deleteModeOn];
    }
    
    [self setNeedsLayout];
}

- (void)reload {
    [self fillScroll];
    [self layoutIfNeeded];
}

#pragma mark - scrollView delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollViewLocal willDecelerate:(BOOL)decelerate {
    [self normilizeOffsetOfScrollView:scrollViewLocal];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollViewLocal {
    [self normilizeOffsetOfScrollView:scrollViewLocal];
}

- (void)normilizeOffsetOfScrollView:(UIScrollView *)scrollViewLocal {
    CGFloat     contentX                = scrollViewLocal.contentOffset.x;
    CGFloat     leftLimit               = _offsetX;
    CGFloat     rightLimit              = scrollViewLocal.contentSize.width -
                                            scrollViewLocal.frame.size.width;
    CGPoint     offsetPoint;
    
    if (contentX < leftLimit) {
        offsetPoint                     = CGPointZero;
    } else if (contentX > rightLimit - leftLimit) {
        offsetPoint                     = CGPointMake(rightLimit, 0.0);
    } else {
        int     discreteX               = (int)((contentX - leftLimit) /
                                                (_itemSize + _itemDistance));
        CGFloat newX                    = leftLimit + (0.5 + discreteX) * _itemSize +
                                                discreteX * _itemDistance;
        
        offsetPoint                     = CGPointMake(newX, 0.0);
    }
    
    [scrollViewLocal setContentOffset:offsetPoint
                             animated:YES];
}

#pragma mark - delete mode

- (void)deleteModeOn {
    CGFloat     itemTotalWidth                  = _itemSize + _itemDistance;
    NSInteger   itemsLimit                      = items.count - 1;
    
    isDeleteMode                                = YES;
    
    for (int i = 0; i < itemsLimit; i++) {
        CGFloat     itemDelSize                 = _itemSize - resizeItemDelta;
        CGFloat     x                           = _offsetX + i * itemTotalWidth;
        UIView      *item                       = items[i];
        
        CGFloat     delBtnOffset                = 8.0;
        CGSize      delBtnSize                  = CGSizeMake(20.0, 20.0);
        UIButton    *delButton                  = [UIButton new];
        
        delButton.backgroundColor               = [UIColor clearColor];
        delButton.frame                         = CGRectMake(x - delBtnOffset, _offsetY - delBtnOffset,
                                                             delBtnSize.width, delBtnSize.height);
        delButton.tag                           = 100 + i;
        
        [delButton setImage:_delImage
                   forState:UIControlStateNormal];
        
        [delButton addTarget:self
                      action:@selector(deleteItemAction:)
            forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:delButton];
        
        item.frame                              = CGRectMake(x, _offsetY, itemDelSize, itemDelSize);
    }
    
    _addButton.enabled                          = NO;
    [self setNeedsLayout];
}

- (void)deleteModeOff {
    CGFloat     itemTotalWidth                  = _itemSize + _itemDistance;
    
    for (UIView *subview in scrollView.subviews) {
        NSInteger   itemIndex                   = [items indexOfObject:subview];
        
        if ([subview isKindOfClass:[UIButton class]] && itemIndex == NSNotFound) {
            [subview removeFromSuperview];
        } else if (itemIndex != NSNotFound && subview != _addButton) {
            CGFloat x                           = _offsetX + itemIndex * itemTotalWidth;
            
            subview.frame                       = CGRectMake(x, _offsetY, _itemSize, _itemSize);
        }
    }
    
    _addButton.enabled                          = YES;
    isDeleteMode                                = NO;
    [self layoutIfNeeded];
}


#pragma mark - selectors

-(void)gestureHandler:(UILongPressGestureRecognizer *)gesture {
    if (_editable && gesture.state == UIGestureRecognizerStateBegan) {
        if (isDeleteMode) {
            [self deleteModeOff];
        } else {
            [self deleteModeOn];
        }
    }
}

- (void)deleteItemAction:(UIButton *)sender {
    [items removeObjectAtIndex:sender.tag - 100];
    
    CGFloat     itemTotalWidth                  = _itemSize + _itemDistance;
    NSInteger   itemsLimit                      = items.count - 1;
    
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < itemsLimit; i++) {
        CGFloat     itemDelSize                 = _itemSize - resizeItemDelta;
        CGFloat     x                           = _offsetX + i * itemTotalWidth;
        UIView      *item                       = items[i];
        
        CGFloat     delBtnOffset                = 8.0;
        CGSize      delBtnSize                  = CGSizeMake(20.0, 20.0);
        UIButton    *delButton                  = [UIButton new];
        
        item.clipsToBounds                      = YES;
        item.frame                              = CGRectMake(x, _offsetY, itemDelSize, itemDelSize);
        item.layer.cornerRadius                 = _itemCornerRadius;
        [scrollView addSubview:item];
        
        delButton.backgroundColor               = [UIColor clearColor];
        delButton.frame                         = CGRectMake(x - delBtnOffset, _offsetY - delBtnOffset,
                                                             delBtnSize.width, delBtnSize.height);
        delButton.tag                           = 100 + i;
        [delButton setImage:_delImage
                   forState:UIControlStateNormal];
        
        [delButton addTarget:self
                      action:@selector(deleteItemAction:)
            forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:delButton];
    }
    _addButton.frame                            = CGRectMake(_offsetX + itemsLimit * itemTotalWidth, _offsetY,
                                                             _itemSize, _itemSize);
    [scrollView addSubview:_addButton];
    
    scrollView.contentSize                      = CGSizeMake(2 * _offsetX + items.count * itemTotalWidth - _itemDistance,
                                                             2 * _offsetY + _itemSize);
    [self setNeedsLayout];
}


#pragma mark - setters

- (void)setAddImage:(UIImage *)addImage {
    _addImage                                   = addImage;
    
    if (_addButton) {
        [_addButton setImage:_addImage
                    forState:UIControlStateNormal];
    }
}

- (void)setDelImage:(UIImage *)delImage {
    _delImage                                   = delImage;
}

- (void)setEditable:(BOOL)editable {
    _editable                                   = editable;
    if (_editable) {
        if (_addButton == nil) {
            _addButton                          = [UIButton new];
            if (_addImage) {
                [_addButton setImage:_addImage
                            forState:UIControlStateNormal];
            }
        }
        [items addObject:_addButton];
    } else {
        [items removeLastObject];
        if (isDeleteMode) {
            [self deleteModeOff];
        }
    }
    [self fillScroll];
}

- (void)setItemCornerRadius:(CGFloat)itemCornerRadius {
    if (_itemShape == rthItemShapeCustomRadius) {
        _itemCornerRadius                       = itemCornerRadius;
        [self fillScroll];
    }
}

- (void)setItemDistance:(CGFloat)itemDistance {
    BOOL    defaultX                            = _offsetX == 2 * _itemDistance;
    BOOL    defaultY                            = _offsetY == _itemDistance;
    
    _itemDistance                               = itemDistance;
    
    if (defaultX) {
        _offsetX                                = 2 * itemDistance;
    }
    if (defaultY) {
        _offsetY                                = itemDistance;
    }
    [self fillScroll];
}

- (void)setItemShape:(RTHItemShape)itemShape {
    _itemShape                                  = itemShape;
    
    if (itemShape == rthItemShapeRound) {
        _itemCornerRadius                       = _itemSize / 2;
    } else if (itemShape == rthItemShapeSquare) {
        _itemCornerRadius                       = 0;
    }
}

- (void)setItemSize:(CGFloat)itemSize {
    _itemSize                                   = itemSize;
    
    if (_itemShape == rthItemShapeRound) {
        _itemCornerRadius                       = itemSize / 2;
    }
    [self fillScroll];
}

- (void)setOffsetX:(CGFloat)offsetX {
    _offsetX                                    = offsetX;
    [self fillScroll];
}

- (void)setOffsetY:(CGFloat)offsetY {
    _offsetY                                    = offsetY;
    [self fillScroll];
}


@end
