//
//  ViewController.m
//  LoginDemov3
//
//  Created by Zsombor on 2017. 09. 12..
//  Copyright © 2017. Zsombor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *UsernameField;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@end

@implementation ViewController

- (NSDictionary*)passwordStore {
    NSString* filename = [[NSBundle mainBundle] pathForResource:@"Accounts"
                                                         ofType:@"plist"
                                                    inDirectory:nil];
    return [[NSDictionary alloc] initWithContentsOfFile:filename];
}

- (BOOL)checkLogin{
    NSString* userKeyPath = [NSString stringWithFormat:@"Username"];
    NSString* passKeyPath = [NSString stringWithFormat:@"Password"];
    NSString* expectedUsername =  [self.passwordStore valueForKeyPath:userKeyPath];
    NSString* expectedPassword = [self.passwordStore valueForKeyPath:passKeyPath];
    return ([_UsernameField.text isEqual: expectedUsername] && [_PasswordField.text isEqual: expectedPassword]);
    }

- (IBAction)LoginButtonPressed:(id)sender {
    if ([self checkLogin]) {
        [[[UIAlertView alloc] initWithTitle:@"Login result" message:@"Logged in successfully!"
                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Login result" message:@"Failed."
                                   delegate:nil cancelButtonTitle:@"Sorry" otherButtonTitles:nil] show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _UsernameField.delegate = self;
    _PasswordField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
