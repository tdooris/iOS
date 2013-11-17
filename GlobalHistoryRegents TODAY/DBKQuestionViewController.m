//
//  DBKQuestionViewController.m
//  GlobalHistoryRegents
//
//  Created by Timothy Dooris on 11/13/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKQuestionViewController.h"
#import "DBKQuiz.h"
#import <QuartzCore/QuartzCore.h>

@interface DBKQuestionViewController ()

@property (weak, nonatomic) IBOutlet UILabel * questionLabel;
@property (weak, nonatomic) IBOutlet UILabel * answer1Label;
@property (weak, nonatomic) IBOutlet UILabel * answer2Label;
@property (weak, nonatomic) IBOutlet UILabel * answer3Label;
@property (weak, nonatomic) IBOutlet UILabel * answer4Label;
@property (weak, nonatomic) IBOutlet UIButton * answer1Button;
@property (weak, nonatomic) IBOutlet UIButton * answer2Button;
@property (weak, nonatomic) IBOutlet UIButton * answer3Button;
@property (weak, nonatomic) IBOutlet UIButton * answer4Button;
@property (weak, nonatomic) IBOutlet UILabel *explanation;

@property (weak, nonatomic) IBOutlet UIImageView * movie1;
@property (weak, nonatomic) IBOutlet UIImageView * movie2;
@property (weak, nonatomic) IBOutlet UIImageView * movie3;
@property (weak, nonatomic) IBOutlet UILabel * statusLabel;
@property (weak, nonatomic) IBOutlet UIButton * startButton;
@property (weak, nonatomic) IBOutlet UIButton * infoButton;
    @property (strong, nonatomic) IBOutlet UIScrollView *scroller;


@property (assign, nonatomic) NSInteger answer;


    
@end

@implementation DBKQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.quizIndex = 999;
    self.quiz = [[DBKQuiz alloc] initWithQuiz:@"Questions"];
    
    [self nextQuizItem];
    self.questionLabel.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
    tempScrollView.contentSize=CGSizeMake(320,750);
  /*
    self.answer1Button.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.answer2Button.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.answer3Button.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.answer4Button.titleLabel.adjustsFontSizeToFitWidth = TRUE;

    */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextQuizItem
{

    [self.scroller setContentOffset:CGPointZero animated:YES];

    if (self.quizIndex == 999) {
        self.quizIndex = 0;
        self.statusLabel.text = @"";
    } else if ((self.quiz.quizCount-1) > self.quizIndex) {
        self.quizIndex++;
    } else {
        self.quizIndex = 0;
        self.statusLabel.text = @"";
    }
    
    if (self.quiz.quizCount >= self.quizIndex + 1) {
        [self.quiz nextQuestion:self.quizIndex];
        self.questionLabel.text = self.quiz.question;
       [self.answer1Button setTitle:self.quiz.ans1 forState:UIControlStateNormal];
        self.answer1Button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.answer2Button setTitle:self.quiz.ans2 forState:UIControlStateNormal];
        self.answer2Button.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.answer2Button.titleLabel.lineBreakMode = NSLineBreakByClipping; //<-- MAGIC LINE


        [self.answer3Button setTitle:self.quiz.ans3 forState:UIControlStateNormal];
        self.answer3Button.titleLabel.adjustsFontSizeToFitWidth = YES;

        [self.answer4Button setTitle:self.quiz.ans4 forState:UIControlStateNormal];
        self.answer4Button.titleLabel.adjustsFontSizeToFitWidth = YES;

        self.explanation.text = self.quiz.explanation;
     } else {
        self.quizIndex = 0;
        [self quizDone];
    }
    
    // reset fields for next question
    self.answer1Button.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
    self.answer2Button.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
    self.answer3Button.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
    self.answer4Button.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];

    
    self.answer1Button.hidden = NO;
    self.answer2Button.hidden = NO;
    self.answer3Button.hidden = NO;
    self.answer4Button.hidden = NO;
    //use the following to disable interactoin:
    
    //self.answer1Button.userInteractionEnabled = NO;
    self.explanation.hidden = YES;
    self.startButton.hidden = YES;

    
}


- (void)checkAnswer
{
    /*Add a border around the correct answer!!
     
    if(self.answer == 1)
    {
        self.answer1Label.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.answer1Label.layer.borderWidth = 5.0;
            }
    */
    
    
    if ([self.quiz checkQuestion:self.quizIndex forAnswer:_answer]) {
        if (self.answer == 1) {
            self.answer1Button.backgroundColor = [UIColor greenColor];
            
        } else if (self.answer == 2) {
            self.answer2Button.backgroundColor = [UIColor greenColor];
        } else if (self.answer == 3) {
            self.answer3Button.backgroundColor = [UIColor greenColor];
        } else if (self.answer == 4) {
            self.answer4Button.backgroundColor = [UIColor greenColor];
        }
    } else {
        if (self.answer == 1) {
            self.answer1Button.backgroundColor = [UIColor redColor];
        } else if (self.answer == 2) {
            self.answer2Button.backgroundColor = [UIColor redColor];
        } else if (self.answer == 3) {
            self.answer3Button.backgroundColor = [UIColor redColor];
        }
        else if (self.answer == 4) {
            self.answer4Button.backgroundColor = [UIColor redColor];
        }
    }
    
    self.statusLabel.text = [NSString stringWithFormat:@"Correct: %d Incorrect: %d",self.quiz.correctCount, self.quiz.incorrectCount];
    
 /*   self.answer1Button.hidden = YES;
    self.answer2Button.hidden = YES;
    self.answer3Button.hidden = YES;
    self.answer4Button.hidden = YES;  */
    self.explanation.hidden = NO;
    
    self.startButton.hidden = NO;
    
    //scroll down to see explanation
    [self.startButton setTitle:@"Next" forState:UIControlStateNormal];
    CGPoint bottomOffset = CGPointMake(0, self.scroller.contentSize.height - self.scroller.bounds.size.height);
    [self.scroller setContentOffset:bottomOffset animated:YES];
}

- (IBAction)ans1Action:(id)sender
{
    self.answer = 1;
    [self checkAnswer];
}

- (IBAction)ans2Action:(id)sender
{
    self.answer = 2;
    [self checkAnswer];
}

- (IBAction)ans3Action:(id)sender
{
    self.answer = 3;
    [self checkAnswer];
}
- (IBAction)ans4Action:(id)sender {
    self.answer = 4;
    [self checkAnswer];
}


- (IBAction)startAgain:(id)sender
{
    if(self.quizIndex == 9){
        [self quizDone];
    }
    
    else{
        [self nextQuizItem];
    }
}


- (void)quizDone
{
    if (self.quiz.correctCount) {
        self.statusLabel.text = [NSString stringWithFormat:@"Quiz Done - Score %d%%", self.quiz.quizCount / self.quiz.correctCount];
    } else {
        self.statusLabel.text = @"Quiz Done - Score: 0%";
    }
    [self.startButton setTitle:@"Try Again" forState:UIControlStateNormal];
    self.quizIndex = 999;
}
@end
