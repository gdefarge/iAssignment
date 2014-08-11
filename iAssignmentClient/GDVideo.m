//
//  GDVideo.m
//  iAssignmentClient
//

#import "GDVideo.h"

@implementation GDVideo
@synthesize cellText;

- (NSString *)cellText
{
    NSMutableString * result = [[NSMutableString alloc] init];
    
    [result appendString:@"Video number "];
    [result appendString:[@(self.id) stringValue]];
    [result appendString:@" has title: "];
    [result appendString:self.title];
    
    return result;
}

@end
