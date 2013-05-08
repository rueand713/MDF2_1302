//
//  alertViewClass.h
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/21/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alertViewClass : UIViewController

+ (void)showAlertWithMessage:(NSString *)title message:(NSString *)message confirmText:(NSString *)confirm cancelText:(NSString *)cancel;

@end
