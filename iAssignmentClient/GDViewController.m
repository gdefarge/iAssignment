//
//  GDViewController.m
//  iAssignmentClient
//  Useful information available at:
//  http://spring.io/guides/gs/consuming-rest-ios/


#import "GDViewController.h"
#import "GDVideo.h"

@interface GDViewController ()
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) NSMutableArray *videos; // list of GDVideo
@property (strong, nonatomic) IBOutlet UITableView *tableViewController;


@end

@implementation GDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableViewController.dataSource = self;
    self.tableViewController.delegate = self;
    self.urlTextField.delegate = self;
    self.videos = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self requestVideos];
}

#pragma mark Keyboard management
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

- (void)requestVideos
{
    // Get url of the server from the GUI
    NSMutableString *guiInput = [[NSMutableString alloc] initWithString:self.urlTextField.text];
    [guiInput appendString:@"/video"];
    NSURL *url = [NSURL URLWithString:guiInput];
    
    // Perform the http request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             // Empty the local list of videos (on iOS device)
             [self.videos removeAllObjects];
             
             // Get list of videos from JSON result of the request
             NSArray * videos = [NSJSONSerialization JSONObjectWithData:data
                                                                options:0
                                                                  error:NULL];
             NSLog(@"JSON received: %@", videos);
             
             // Add each video from the JSON result to the the local list of videos
             for (NSDictionary *dico in videos) {
                 
                 GDVideo *currentVideo = [[GDVideo alloc] init];
                 
                 currentVideo.id = [[dico objectForKey:@"id"] integerValue];
                 currentVideo.title = [dico objectForKey:@"title"];
                 currentVideo.duration = [[dico objectForKey:@"duration"] integerValue];
                 
                 [self.videos addObject:currentVideo];
             }
             
             // Refresh the table of the GUI
            [self.tableViewController reloadData];
         }
     }];
}


#pragma mark GUI interactions
- (IBAction)refreshClick:(id)sender
{
    [self requestVideos];
    [self.tableViewController reloadData];
}

- (IBAction)urlEditingEnded:(id)sender
{
    [self requestVideos];
    [self.tableViewController reloadData];
}


#pragma mark Table View Controller methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GDVideo *currentVideo = self.videos[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = currentVideo.cellText;
    NSLog(@"cellText %@", [currentVideo cellText]);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO implement code to receive user selection (click on a cell of TableView)
    
}


@end
