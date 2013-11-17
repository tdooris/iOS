//
//  DBKQuiz.m
//  GlobalHistoryRegents
//
//  Created by Timothy Dooris on 11/13/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKQuiz.h"

@interface DBKQuiz()

@property (nonatomic, strong) NSString * question;
@property (nonatomic, strong) NSString * ans1;
@property (nonatomic, strong) NSString * ans2;
@property (nonatomic, strong) NSString * ans3;
@end

@implementation DBKQuiz



- (id)initWithQuiz:(NSString*)plistName

{
    
    if ((self = [super init]))
    {
        NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        self.questionArray = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
        self.quizCount = [self.questionArray count];
        self.tipCount = 0;
    }
    return self;
}

- (void) nextQuestion: (NSUInteger) idx
{
    self.question = [NSString stringWithFormat:@"'%@'",self.questionArray[idx][@"question"]];
    
    self.ans1 = self.questionArray[idx][@"ans1"];
    self.ans2 = self.questionArray[idx][@"ans2"];
    self.ans3 = self.questionArray[idx][@"ans3"];
    self.tip = self.questionArray[idx][@"tip"];
    
    if (idx == 0) {
        self.correctCount = 0;
        self.incorrectCount = 0;
        self.tipCount = 0;
    }
    
}

- (BOOL) checkQuestion: (NSUInteger) question forAnswer: (NSUInteger) answer
{
    NSString * ans = self.questionArray[question] [@"answer"];
    if  ([ans intValue] == answer) {
        self.correctCount++;
        return YES;
    } else  {
        self.incorrectCount++;
        return NO;
    }
}

@end
