//
//  MCTweetbotActivity.m
//  Gif Finder
//
//  Created by Matthew Cheetham on 14/03/2013.
//  Copyright (c) 2013 Matthew Cheetham. All rights reserved.
//

#import "MCTweetbotActivity.h"

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
    return [UIImage imageNamed:@"tweetbot"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]]){
        return NO;
    }
    
    for (UIActivityItemProvider *item in activityItems) {
        
        if ([item isKindOfClass:[UIImage class]]) {
            
            return NO;
            
        }
        
    }
    
    return YES;
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
