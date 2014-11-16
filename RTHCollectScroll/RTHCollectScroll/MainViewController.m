//
//  MainViewController.m
//  RTHCollectScroll
//
//  Created by Ratsh on 12.11.14.
//  Copyright (c) 2014 rth. All rights reserved.
//

#import "MainViewController.h"
#import "RTHCollectionScrollView.h"
#import "SettingsView.h"

@interface MainViewController () {
    int                         addItemIndex;
    NSMutableArray              *viewArray;
    RTHCollectionScrollView     *rthScroll;
    SettingsView                *settingsView;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingsInit];
    [self rthScrollInit];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - init methods

- (void)rthScrollInit {
    rthScroll                           = [RTHCollectionScrollView new];
    rthScroll.backgroundColor           = [UIColor whiteColor];
    rthScroll.editable                  = YES;
    rthScroll.frame                     = CGRectMake(30.0, 40.0, 10.0, 60.0);
    rthScroll.visibleItems              = 4;
    rthScroll.itemDistance              = 15.0;
    rthScroll.itemSize                  = 25.0;
    rthScroll.layer.borderWidth         = 1;
    rthScroll.addImage                  = [UIImage imageNamed:@"AddButton"];
    rthScroll.delImage                  = [UIImage imageNamed:@"DelButton"];
    [rthScroll.addButton addTarget:self
                            action:@selector(addItemPressed:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rthScroll];
}

- (void)settingsInit {
    settingsView                        = [SettingsView new];
    settingsView.frame                  = CGRectMake(5.0, 130.0,
                                                     self.view.bounds.size.width - 10.0, 355.0);
    [self.view addSubview:settingsView];
    
    addItemIndex                        = 0;
    
    NSArray *colorArray                 = @[[UIColor redColor],
                                            [UIColor yellowColor],
                                            [UIColor greenColor],
                                            [UIColor blueColor],
                                            [UIColor grayColor]];
    
    viewArray                           = @[].mutableCopy;
    
    for (int i = 0, j = 0; i < 50; i++, j++) {
        UIView *view                    = [UIView new];
        
        if (j > 4) {
            j = 0;
        }
        view.backgroundColor            = colorArray[j];
        
        [viewArray addObject:view];
    }
    
    
    [settingsView.editableSwitch addTarget:self
                                    action:@selector(changeSwitch:)
                          forControlEvents:UIControlEventValueChanged];

    [settingsView.shapeSlider addTarget:self
                                 action:@selector(changeSlider:)
                       forControlEvents:UIControlEventValueChanged];
    
    
    [settingsView.applyButton addTarget:self
                                 action:@selector(applyButtonPressed)
                       forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - selectors

- (void)changeSwitch:(UISwitch *)sender {
    if (sender.isOn) {
        rthScroll.editable              = YES;
    } else {
        rthScroll.editable              = NO;
    }
}

- (void)changeSlider:(UISlider *)sender {
    if ((int)sender.value == rthScroll.itemShape) {
        return;
    }
    
    switch ((int)sender.value) {
        case rthItemShapeRound:
            settingsView.shapeLabel.text                = @"Round";
            settingsView.radiusField.backgroundColor    = [UIColor lightGrayColor];
            rthScroll.itemShape                         = rthItemShapeRound;
            break;
        case rthItemShapeSquare:
            settingsView.shapeLabel.text                = @"Square";
            settingsView.radiusField.backgroundColor    = [UIColor lightGrayColor];
            rthScroll.itemShape                         = rthItemShapeSquare;
            break;
        case rthItemShapeCustomRadius:
            settingsView.shapeLabel.text                = @"Custom radius";
            settingsView.radiusField.backgroundColor    = [UIColor whiteColor];
            rthScroll.itemShape                         = rthItemShapeCustomRadius;
            break;
        default:
            break;
    }
}

- (void)applyButtonPressed {
    rthScroll.itemDistance              = [settingsView.distanceField.text floatValue];
    rthScroll.itemSize                  = [settingsView.sizeField.text floatValue];
    rthScroll.offsetX                   = [settingsView.offsetXField.text floatValue];
    rthScroll.offsetY                   = [settingsView.offsetYField.text floatValue];
    rthScroll.itemCornerRadius          = [settingsView.radiusField.text floatValue];
    rthScroll.visibleItems              = [settingsView.itemsField.text integerValue];
}

- (void)addItemPressed:(UIButton *)sender {
    [rthScroll addItem:viewArray[addItemIndex]];
    
    addItemIndex                       += 1;
    if (addItemIndex == 50) {
        return;
    }
}


@end
