//
//  DBKQuestionViewController.h
//  GlobalHistoryRegents
//
//  Created by Timothy Dooris on 11/13/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//


#import <UIKit/UIKit.h>

@class DBKQuiz;


@interface DBKQuestionViewController : UIViewController

@property (nonatomic, assign) NSInteger quizIndex;
@property (nonatomic, strong) DBKQuiz * quiz;

@end
