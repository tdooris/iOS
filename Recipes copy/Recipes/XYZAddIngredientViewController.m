//
//  XYZAddIngredientViewController.m
//  Recipes
//
//  Created by Timothy Dooris on 10/30/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "XYZAddIngredientViewController.h"
#import "XYZIngredient.h"

@interface XYZAddIngredientViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation XYZAddIngredientViewController

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
    _textField.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    
    if (self.textField.text.length > 0) {
    }
    self.ingredient = [[XYZIngredient alloc] init];
    self.ingredient.ingredientName = self.textField.text;
    
}
@end
