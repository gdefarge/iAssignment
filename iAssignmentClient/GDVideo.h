//
//  GDVideo.h
//  iAssignmentClient
//

#import <Foundation/Foundation.h>

@interface GDVideo : NSObject

@property (nonatomic) int id;
@property (nonatomic) NSString * title;
@property (nonatomic) int duration;

@property (nonatomic, readonly) NSString * cellText;

@end
