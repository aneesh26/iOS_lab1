/**
 * Copyright 2015 Aneesh Shastry,
 * <p/>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p/>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p/>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * <p/>
 * Purpose: An iOS application to manipulate Waypoints
 *
 * @author Aneesh Shastry ashastry@asu.edu
 *         MS Computer Science, CIDSE, IAFSE, Arizona State University
 * @version March 23, 2015
 */

#import "ViewController.h"
#import "Waypoint.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *lattitudeTV;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTV;
@property (weak, nonatomic) IBOutlet UITextField *nameTV;
@property (weak, nonatomic) IBOutlet UITextField *distanceTV;
@property (weak, nonatomic) IBOutlet UITextField *toTV;


@property (strong, nonatomic) NSMutableDictionary * wpLib;
@property (strong, nonatomic) NSMutableDictionary * tempLib;



@property (strong, nonatomic) UIPickerView * namePicker;
@property (strong, nonatomic) UIPickerView * toPicker;


@property (strong, nonatomic) NSString * NewWpName;
@property (strong, nonatomic) NSString * NewWpLat;
@property (strong, nonatomic) NSString * NewWpLon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lattitudeTV.delegate = self;
    self.lattitudeTV.keyboardType = UIKeyboardTypeNumbersAndPunctuation;

    self.longitudeTV.delegate = self;
    self.longitudeTV.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    Waypoint * ny = [[Waypoint alloc] initWithLat:40.7127 lon:-74.0059 name:@"New-York"];
    Waypoint * asup = [[Waypoint alloc] initWithLat:33.3056 lon:-111.6788 name:@"ASUPoly"];
    Waypoint * asub = [[Waypoint alloc] initWithLat:33.4235 lon:-111.9389 name:@"ASUBrickyard"];
    Waypoint * paris = [[Waypoint alloc] initWithLat:48.8567 lon:2.3508 name:@"Paris"];
    Waypoint * moscow = [[Waypoint alloc] initWithLat:55.75 lon:37.6167 name:@"Moscow"];
  //  Waypoint * wp;
    
    self.wpLib = [[NSMutableDictionary alloc] init];
    
    [self.wpLib setObject:ny forKey:@"New-York"];
    [self.wpLib setObject:asup forKey:@"ASUPoly"];
    [self.wpLib setObject:asub forKey:@"ASUBrickyard"];
    [self.wpLib setObject:paris forKey:@"Paris"];
    [self.wpLib setObject:moscow forKey:@"Moscow"];
    
   // self.wpLib = @{@"New-York":ny,@"ASUPoly":asup,@"ASUBrick":asub,@"Paris":paris,@"Moscow":moscow};
    
    
    self.namePicker = [[UIPickerView alloc] init];
    self.namePicker.delegate = self;
    self.namePicker.dataSource = self;
    
    self.toPicker = [[UIPickerView alloc] init];
    self.toPicker.delegate = self;
    self.toPicker.dataSource = self;
    
    self.toTV.inputView = self.toPicker;
    self.nameTV.inputView = self.namePicker;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addButtonClicked:(id)sender {
    
    UIAlertView * alertLon = [[UIAlertView alloc] initWithTitle:@"Waypoint Longitude" message:@"Enter Waypoint Longitude" delegate: self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    alertLon.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertLon show];
    [[alertLon textFieldAtIndex:0] setDelegate:self];
    [[alertLon textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[alertLon textFieldAtIndex:0] becomeFirstResponder];
    
    UIAlertView * alertLat = [[UIAlertView alloc] initWithTitle:@"Waypoint Lattitude" message:@"Enter Waypoint Lattitude" delegate: self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Next", nil];
    alertLat.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertLat show];
    
    [[alertLat textFieldAtIndex:0] setDelegate:self];
    [[alertLat textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[alertLat textFieldAtIndex:0] becomeFirstResponder];
    
   
    UIAlertView * alertName = [[UIAlertView alloc] initWithTitle:@"Waypoint Name" message:@"Enter Waypoint Name" delegate: self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Next", nil];
    alertName.alertViewStyle = UIAlertViewStylePlainTextInput;
 
    [alertName show];
    
 
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  //  NSLog(@"Add button Clicked");
    
  
    NSString *title = [alertView title];
  
    if([title isEqual:@"Waypoint Name"]){
        self.NewWpName = [alertView textFieldAtIndex:0].text;
    }
    
    if([title isEqual:@"Waypoint Lattitude"]){
        self.NewWpLat = [alertView textFieldAtIndex:0].text;
    }
    
    if([title isEqual:@"Waypoint Longitude"]){
        self.NewWpLon = [alertView textFieldAtIndex:0].text;
        

        
        
        if(!([self.NewWpName isEqual:@""] || [self.NewWpLat isEqual:@""]|| [self.NewWpLon isEqual:@""]) ){
            
            //set the text views with the new values
            [self.lattitudeTV setText:self.NewWpLat];
            [self.longitudeTV setText:self.NewWpLon];
            [self.nameTV setText:self.NewWpName];
            [self.distanceTV setText:@""];
            [self.toTV setText:@""];
            
            
            [self addWaypoint];
            
            self.NewWpLat = @"";
            self.NewWpLon = @"";
            self.NewWpName = @"";
            
            [self.namePicker reloadAllComponents];
            [self.toPicker reloadAllComponents];
            
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Add Waypoint " message:@"Incomplete Input" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            // optional - add more buttons:
            [alert addButtonWithTitle:@"OK"];
            [alert show];
            
        }
        
        
    }
    
    if([title isEqualToString:@"Warning"]){
        NSString *buttonText = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([buttonText isEqualToString:@"NO"])
        {
            
        }
        else if([buttonText isEqualToString:@"YES"])
        {
            NSString * temp = self.nameTV.text;
            [self deleteWaypoint];
            
            [self.namePicker reloadAllComponents];
            [self.toPicker reloadAllComponents];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Task Complete " message:[[@"Waypoint '" stringByAppendingString:temp] stringByAppendingString:@"' removed."] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            // optional - add more buttons:
            [alert addButtonWithTitle:@"OK"];
            [alert show];
            
            
        }
  
    }
    
    
    
    
    
    
}

-(void) deleteWaypoint{
    [self.wpLib removeObjectForKey:self.nameTV.text];
    
    [self.nameTV setText:@""];
    [self.lattitudeTV setText:@""];
    [self.longitudeTV setText:@""];
    [self.distanceTV setText:@""];
    [self.toTV setText:@""];

    
    
    
}

-(void)addWaypoint{
    Waypoint * newWP = [[Waypoint alloc] initWithLat:[self.NewWpLat doubleValue] lon:[self.NewWpLon doubleValue] name:self.NewWpName];

    [self.wpLib setObject:newWP forKey:newWP.name];
    
    
}


- (IBAction)removeButtonClicked:(id)sender {

    
    if( ![self.nameTV.text isEqual:@"" ]){
        
    
    UIAlertView *deleteAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                          message:[[@"Remove '" stringByAppendingString: self.nameTV.text] stringByAppendingString:@"' ?"]
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [deleteAlert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Remove Waypoint " message:@"Please select a Waypoint" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSArray * keys = [self.wpLib allKeys];
    if(row < keys.count){
        
        
    if(pickerView == self.toPicker){
        [self.toTV resignFirstResponder];
        // add code to handle the to picker - to populate the TO text field
        // to get the distance
        NSArray * keys = [self.wpLib allKeys];
        [self.toTV setText:keys[row]];
        
        //get name wp and to wp.. call the functions inside name wp with the to wp lat and lon
        if(![self.nameTV.text isEqual:@""])
        {
            [self calculateDistance ];
        }
        
        
        
    }else{
        [self.nameTV resignFirstResponder];
        //add code to handle the name text picker, i.e., to populate the fields lat, lon, name
        NSArray * keys = [self.wpLib allKeys];
        NSString * selectedKey = keys[row];
        
        [self.nameTV setText:keys[row]];
        Waypoint * wpObject = [self.wpLib objectForKey:selectedKey];
        [self.lattitudeTV setText:[NSString stringWithFormat:@"%4f",[wpObject lat]]];
        [self.longitudeTV setText:[NSString stringWithFormat:@"%4f",[wpObject lon]]];
        [self.nameTV setText:[wpObject name]];
        
        if(![self.toTV.text isEqual:@""])
        {
            [self calculateDistance ];
        }
        
        
    }
    }
    
}



- (void) calculateDistance;{
    Waypoint * nameWP = [self.wpLib objectForKey:self.nameTV.text];
    Waypoint * toWP = [self.wpLib objectForKey:self.toTV.text];
    //NSLog(@"Lattitude: %f",toWP.lat);
   // NSLog(@"Longitude: %f",toWP.lon);
    double dist = [nameWP distanceGCTo: toWP.lat lon: toWP.lon scale: Statute];
   // NSLog(@"Distance: %f",dist);
    double dir = [nameWP bearingGCInitTo: toWP.lat lon: toWP.lon];
    
    NSString * resultSTring = [NSString stringWithFormat: @"%.2f mi bearing %.2f",dist,dir];
    
    [self.distanceTV setText:resultSTring];
    
    
    
    
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray * keys = [self.wpLib allKeys];
    NSString * returnString = @"Unknown Key";
    if(row < keys.count){
        returnString = keys[row];
    }
    //NSLog(@"%@",returnString);
    return returnString;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.wpLib allKeys].count;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.lattitudeTV resignFirstResponder];
    [self.longitudeTV resignFirstResponder];
    [self.nameTV resignFirstResponder];
    [self.toTV resignFirstResponder];
    [self.distanceTV resignFirstResponder];
};

@end
