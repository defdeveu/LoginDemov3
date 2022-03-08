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

- (BOOL)checkLogin:(NSString *) password {
    NSString* passKeyPath = [NSString stringWithFormat:@"Password"];
    NSString* expectedPassword = [self.passwordStore valueForKeyPath:passKeyPath];
    return ([password isEqual: expectedPassword]);
    }

- (void) userLoginSucceeded{
    [[[UIAlertView alloc] initWithTitle:@"Login result" message:@"Logged in successfully!"
                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void) userLoginFailed{
    [[[UIAlertView alloc] initWithTitle:@"Login result" message:@"Failed."
                               delegate:nil cancelButtonTitle:@"Sorry" otherButtonTitles:nil] show];
}

- (IBAction)LoginButtonPressed:(id)sender {
    if ([self checkLogin:[_PasswordField text]]) {
        [self userLoginSucceeded];
    }else{
        [self userLoginFailed];
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
