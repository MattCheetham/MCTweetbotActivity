//
//  MCTweetbotActivity.m
//
//  Created by Matthew Cheetham on 14/03/2013.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MCTweetbotActivity.h"

@interface MCTweetbotActivity ()

@property (nonatomic, strong) NSString *shareString;

@end

@implementation MCTweetbotActivity

- (NSString *)activityType
{
    return @"UIActivityTypePostToTweetbot";
}

- (NSString *)activityTitle
{
    return @"Tweetbot";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"tweetbot_icon"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]]){
        return NO;
    }
    
    for (UIActivityItemProvider *item in activityItems) {
        
        if ([item isKindOfClass:[NSString class]] || [item isKindOfClass:[NSURL class]]) {
            
            return YES;
            
        }
        
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (UIActivityItemProvider *item in activityItems) {
        
        if ([item isKindOfClass:[NSURL class]]) {
            
            self.shareString = [(self.shareString ? self.shareString : @"") stringByAppendingFormat:@"%@%@",(self.shareString ? @" " : @""),[(NSURL *)item absoluteString]];
        
        } else if ([item isKindOfClass:[NSString class]]) {
            
            self.shareString = [(self.shareString ? self.shareString : @"") stringByAppendingFormat:@"%@%@",(self.shareString ? @" " : @""),item];
        
        }
        
    }
}

- (void)performActivity
{
    NSURL *tweetbotURL = [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///post?text=%@", self.shareString]];
    [[UIApplication sharedApplication] openURL:tweetbotURL];
    
    [self activityDidFinish:YES];
}

@end
