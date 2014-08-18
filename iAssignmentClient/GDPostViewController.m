//
//  GDPostViewController.m
//  iAssignmentClient
//

#import "GDPostViewController.h"

@interface GDPostViewController ()
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *subjectTextField;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@end

@implementation GDPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.titleTextField.delegate = self;
    self.subjectTextField.delegate = self;
    self.urlTextField.delegate = self;
}

#pragma mark Keyboard management
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

#pragma mark Click management

- (IBAction)postClick:(id)sender
{
    // Get values of the video from the GUI
    NSString *title = self.titleTextField.text;
    NSString *subject = self.subjectTextField.text;
    
    // Get url of the server from the GUI
    NSMutableString *guiInput = [[NSMutableString alloc] initWithString:self.urlTextField.text];
    [guiInput appendString:@"/video"];
    NSURL *url = [NSURL URLWithString:guiInput];
    
    // Build the JSON
    NSDictionary *inputData = [[NSDictionary alloc] initWithObjectsAndKeys:
                               title, @"title",
                               subject, @"subject",
                               nil];
    
    NSError *errorJson = nil;
    NSData *jsonInputData = [NSJSONSerialization dataWithJSONObject:inputData options:NSJSONWritingPrettyPrinted error:&errorJson];
    NSString *jsonInputString = [[NSString alloc] initWithData:jsonInputData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON to send: %@", jsonInputString);
    
    // Perform the http request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[jsonInputString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (connectionError == nil) {
            // Get the result of the POST request
            NSLog(@"response: %@", [response debugDescription]);
        }
        else {
            NSLog(@"connectionError %@", [connectionError debugDescription]);
        }
    }];
}


@end
