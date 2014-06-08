//
//  InsertionVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "InsertionVC.h"
#import "Annotation.h"
#import "MapsVC.h"
#import "Server.h"

@interface InsertionVC () <UITextFieldDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (weak, nonatomic) IBOutlet UITextField *raceTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextField *detailsTextField;


@property (weak, nonatomic) IBOutlet UILabel *localizationLabel;

@end

@implementation InsertionVC

- (IBAction)selectPhoto:(id)sender {
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backToMaps:(id)sender {

	Server *server = [Server getServer];
	
	NSString *status = self.statusSegmentedControl.selectedSegmentIndex == 0 ? @"Found" : @"Lost";
	
	
	if(self.imageView.image)
	[server insertAnimalOfSpecies:self.speciesTextField.text race:self.raceTextField.text name:self.nameTextField.text text:self.detailsTextField.text withStatus:status withImage:self.imageView.image andLocation:self.coordinate];
	else
	[server insertAnimalOfSpecies:self.speciesTextField.text race:self.raceTextField.text name:self.nameTextField.text text:self.detailsTextField.text withStatus:status withImage:[UIImage imageNamed:@"no_image"] andLocation:self.coordinate];
	
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)backWithoutInsertion:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.speciesTextField.delegate = self;
	self.raceTextField.delegate = self;
	self.nameTextField.delegate = self;
	self.detailsTextField.delegate = self;
	
	self.localizationLabel.text = [NSString stringWithFormat:@"%.2fº, %.2fº",self.coordinate.latitude, self.coordinate.longitude];
	
	UIFont *font=[UIFont fontWithName:@"AmericanTypewriter" size:16.0f];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.statusSegmentedControl setTitleTextAttributes:attributes
										 forState:UIControlStateNormal];
	
}



@end
