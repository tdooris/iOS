//
//  DBKPickQuizViewController.m
//  GlobalHistoryRegents
//
//  Created by Timothy Dooris on 11/16/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKPickQuizViewController.h"
#import "DBKQuestionViewController.h"

@interface DBKPickQuizViewController ()

@end

@implementation DBKPickQuizViewController

- (IBAction)select1:(id)sender {
    self.selectedTopic = @"crossTopicalQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
    

}
- (IBAction)select2:(id)sender {
    self.selectedTopic = @"methodologyQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}
- (IBAction)select3:(id)sender {
    self.selectedTopic = @"ancientWorldQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}
- (IBAction)select4:(id)sender {
    self.selectedTopic = @"expandingZonesQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}

- (IBAction)select5:(id)sender {
    self.selectedTopic = @"globalInteractionsQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}

- (IBAction)select6:(id)sender {
    self.selectedTopic = @"ageofrevolutionsQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}

- (IBAction)select7:(id)sender {
    self.selectedTopic = @"ahalfcenturyQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}

- (IBAction)select8:(id)sender {
    
    self.selectedTopic = @"since1945Questions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}
- (IBAction)select9:(id)sender {
    
    self.selectedTopic = @"globalconnectionsQuestions";
    [self performSegueWithIdentifier:@"pickTopic" sender:self];
}


@synthesize selectedTopic;
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"pickTopic"])
    {
        DBKQuestionViewController *qvc = segue.destinationViewController;
        [qvc setChosenPlist: selectedTopic];
    }
}

@end
