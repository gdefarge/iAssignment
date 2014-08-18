//
//  GDVideo.h
//  iAssignmentClient
//

#import <Foundation/Foundation.h>
#import <Foundation/NSURL.h>

@interface GDVideo : NSObject

@property (nonatomic) int id;
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * subject;
@property (nonatomic) NSString * contentType;
@property (nonatomic) NSURL * dataUrl;
@property (nonatomic) int duration;

@property (nonatomic, readonly) NSString * cellText;

@end
