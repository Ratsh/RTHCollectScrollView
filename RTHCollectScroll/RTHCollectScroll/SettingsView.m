//
//  SettingsView.m
//  RTHCollectScroll
//
//  Created by Ratsh on 15.11.14.
//  Copyright (c) 2014 rth. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

- (id)init {
    self = [super init];
    
    if (self) {
        self.backgroundColor            = [UIColor colorWithWhite:240.0/255.0
                                                            alpha:1.0];
        
        _applyButton                    = [UIButton new];
        _applyButton.layer.borderWidth  = 1.0;
        _applyButton.layer.cornerRadius = 4.0;
        
        [_applyButton setTitle:@"Apply"
                      forState:UIControlStateNormal];
        
        [_applyButton setTitleColor:[UIColor blackColor]
                           forState:UIControlStateNormal];
        
        [self addSubview:_applyButton];
        
        _editableSwitch                 = [UISwitch new];
        _editableSwitch.on              = YES;
        [self addSubview:_editableSwitch];
        
        _shapeSlider                    = [UISlider new];
        _shapeSlider.maximumValue       = 2;
        _shapeSlider.minimumValue       = 0;
        _shapeSlider.value              = 0;
        [self addSubview:_shapeSlider];
        
        [self labelsInit];
        [self textFieldsInit];
    }
    
    return self;
}

- (void)labelsInit {
    CGFloat     fontSize                = 13.0;
    
    _distanceLabel                      = [UILabel new];
    _distanceLabel.font                 = [UIFont systemFontOfSize:fontSize];
    _distanceLabel.text                 = @"Distance between items";
    [self addSubview:_distanceLabel];
    
    _editableLabel                      = [UILabel new];
    _editableLabel.font                 = [UIFont systemFontOfSize:fontSize];
    _editableLabel.text                 = @"Editable";
    [self addSubview:_editableLabel];
    
    _instructionLabel                   = [UILabel new];
    _instructionLabel.font              = [UIFont systemFontOfSize:15.0];
    _instructionLabel.numberOfLines     = 0;
    _instructionLabel.text              = @"Use long touch for delete item. And use again when you need close delete mode.";
    [self addSubview:_instructionLabel];
    
    _itemsNumberLabel                   = [UILabel new];
    _itemsNumberLabel.font              = [UIFont systemFontOfSize:fontSize];
    _itemsNumberLabel.text              = @"Number of items that visible in scroll frame";
    [self addSubview:_itemsNumberLabel];
    
    _offsetXLabel                       = [UILabel new];
    _offsetXLabel.font                  = [UIFont systemFontOfSize:fontSize];
    _offsetXLabel.text                  = @"Offset before first and after last items";
    [self addSubview:_offsetXLabel];
    
    _offsetYLabel                       = [UILabel new];
    _offsetYLabel.font                  = [UIFont systemFontOfSize:fontSize];
    _offsetYLabel.text                  = @"Offset above and below items";
    [self addSubview:_offsetYLabel];
    
    _radiusLabel                        = [UILabel new];
    _radiusLabel.font                   = [UIFont systemFontOfSize:fontSize];
    _radiusLabel.text                   = @"Radius";
    [self addSubview:_radiusLabel];
    
    _shapeLabel                         = [UILabel new];
    _shapeLabel.font                    = [UIFont systemFontOfSize:fontSize];
    _shapeLabel.text                    = @"Round";
    _shapeLabel.textAlignment           = NSTextAlignmentCenter;
    [self addSubview:_shapeLabel];
    
    _sizeLabel                          = [UILabel new];
    _sizeLabel.font                     = [UIFont systemFontOfSize:fontSize];
    _sizeLabel.text                     = @"Size of item";
    [self addSubview:_sizeLabel];
    
    _titleLabel                         = [UILabel new];
    _titleLabel.font                    = [UIFont systemFontOfSize:20.0];
    _titleLabel.text                    = @"Settings:";
    _titleLabel.textAlignment           = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}

- (void)textFieldsInit {
    CGFloat         cornerRadius        = 4.0;
    
    _distanceField                      = [UITextField new];
    _distanceField.layer.borderWidth    = 1.0;
    _distanceField.layer.cornerRadius   = cornerRadius;
    _distanceField.text                 = @"15";
    [self addSubview:_distanceField];
    
    _itemsField                         = [UITextField new];
    _itemsField.layer.borderWidth       = 1.0;
    _itemsField.layer.cornerRadius      = cornerRadius;
    _itemsField.text                    = @"4";
    [self addSubview:_itemsField];

    _offsetXField                       = [UITextField new];
    _offsetXField.layer.borderWidth     = 1.0;
    _offsetXField.layer.cornerRadius    = cornerRadius;
    _offsetXField.text                  = @"30";
    [self addSubview:_offsetXField];
    
    _offsetYField                       = [UITextField new];
    _offsetYField.layer.borderWidth     = 1.0;
    _offsetYField.layer.cornerRadius    = cornerRadius;
    _offsetYField.text                  = @"15";
    [self addSubview:_offsetYField];
    
    _radiusField                        = [UITextField new];
    _radiusField.backgroundColor        = [UIColor lightGrayColor];
    _radiusField.layer.borderWidth      = 1.0;
    _radiusField.layer.cornerRadius     = cornerRadius;
    _radiusField.text                   = @"12.5";
    [self addSubview:_radiusField];
    
    _sizeField                          = [UITextField new];
    _sizeField.layer.borderWidth        = 1.0;
    _sizeField.layer.cornerRadius       = cornerRadius;
    _sizeField.text                     = @"25";
    [self addSubview:_sizeField];
}

- (void)layoutSubviews {
    CGFloat     labelHeight             = 20.0;
    CGFloat     offsetX                 = 5.0;
    CGFloat     offsetY                 = 10.0;
    CGFloat     width                   = self.bounds.size.width;
    
    CGFloat     smallVerticalDist       = 5.0;
    CGFloat     verticalDist            = 10.0;
    
    CGFloat     titleLabelHeight        = 25.0;
    CGFloat     editableLabelWidth      = 80.0;
    CGFloat     shapeElementsWidth      = 150.0;
    CGFloat     fieldWidth              = 40.0;
    CGFloat     fieldOffsetX            = width - offsetX - fieldWidth;
    CGFloat     labelWidth              = fieldOffsetX - offsetX;
    
    CGFloat     btnHeight               = 40.0;
    CGFloat     btnOffsetX              = 50.0;
    CGFloat     btnWidth                = width - 2 * btnOffsetX;
    
    _titleLabel.frame                   = CGRectMake(0.0, offsetY, width, titleLabelHeight);
    offsetY                            += titleLabelHeight + verticalDist;
    
    _editableLabel.frame                = CGRectMake(offsetX, offsetY,
                                                     editableLabelWidth, labelHeight);
    _editableSwitch.frame               = CGRectMake(offsetX + editableLabelWidth, offsetY - 10.0,
                                                     50.0, labelHeight);
    offsetY                            += labelHeight + verticalDist;
    
    _shapeLabel.frame                   = CGRectMake(offsetX, offsetY, shapeElementsWidth, labelHeight);
    offsetY                            += labelHeight + smallVerticalDist;
    _shapeSlider.frame                  = CGRectMake(offsetX, offsetY, shapeElementsWidth, labelHeight);
    
    _radiusLabel.frame                  = CGRectMake(offsetX + shapeElementsWidth + 10.0, offsetY - 10.0,
                                                      50.0, labelHeight);
    _radiusField.frame                  = CGRectMake(offsetX + shapeElementsWidth + 60.0, offsetY - 10.0,
                                                      40.0, labelHeight);
    offsetY                            += labelHeight + 15.0;

    _distanceLabel.frame                = CGRectMake(offsetX, offsetY, labelWidth, labelHeight);
    _distanceField.frame                = CGRectMake(fieldOffsetX, offsetY, fieldWidth, labelHeight);
    offsetY                            += labelHeight + smallVerticalDist;
    
    _sizeLabel.frame                    = CGRectMake(offsetX, offsetY, labelWidth, labelHeight);
    _sizeField.frame                    = CGRectMake(fieldOffsetX, offsetY, fieldWidth, labelHeight);
    offsetY                            += labelHeight + smallVerticalDist;
    
    _offsetXLabel.frame                 = CGRectMake(offsetX, offsetY, labelWidth, labelHeight);
    _offsetXField.frame                 = CGRectMake(fieldOffsetX, offsetY, fieldWidth, labelHeight);
    offsetY                            += labelHeight + smallVerticalDist;
    
    _offsetYLabel.frame                 = CGRectMake(offsetX, offsetY, labelWidth, labelHeight);
    _offsetYField.frame                 = CGRectMake(fieldOffsetX, offsetY, fieldWidth, labelHeight);
    offsetY                            += labelHeight + smallVerticalDist;
    
    _itemsNumberLabel.frame             = CGRectMake(offsetX, offsetY, labelWidth, labelHeight);
    _itemsField.frame                   = CGRectMake(fieldOffsetX, offsetY, fieldWidth, labelHeight);
    offsetY                            += labelHeight + verticalDist;
    
    _applyButton.frame                  = CGRectMake(btnOffsetX, offsetY, btnWidth, btnHeight);
    offsetY                            += btnHeight + smallVerticalDist;
    
    _instructionLabel.frame             = CGRectMake(offsetX, offsetY, width - 2 * offsetX, 2 * labelHeight);
}


@end
