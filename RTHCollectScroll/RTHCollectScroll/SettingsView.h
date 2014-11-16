//
//  SettingsView.h
//  RTHCollectScroll
//
//  Created by Ratsh on 15.11.14.
//  Copyright (c) 2014 rth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UIView


@property (nonatomic) UIButton                      *applyButton;

@property (nonatomic) UILabel                       *distanceLabel;
@property (nonatomic) UILabel                       *editableLabel;
@property (nonatomic) UILabel                       *instructionLabel;
@property (nonatomic) UILabel                       *itemsNumberLabel;
@property (nonatomic) UILabel                       *offsetXLabel;
@property (nonatomic) UILabel                       *offsetYLabel;
@property (nonatomic) UILabel                       *radiusLabel;
@property (nonatomic) UILabel                       *shapeLabel;
@property (nonatomic) UILabel                       *sizeLabel;
@property (nonatomic) UILabel                       *titleLabel;

@property (nonatomic) UISlider                      *shapeSlider;

@property (nonatomic) UISwitch                      *editableSwitch;

@property (nonatomic) UITextField                   *distanceField;
@property (nonatomic) UITextField                   *itemsField;
@property (nonatomic) UITextField                   *offsetXField;
@property (nonatomic) UITextField                   *offsetYField;
@property (nonatomic) UITextField                   *radiusField;
@property (nonatomic) UITextField                   *sizeField;


@end
