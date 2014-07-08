//
//  MCTweetbotActivity.m
//
//  Created by Matthew Cheetham on 14/03/2013.
//  Copyright (c) 2014 Matthew Cheetham.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  If you happen to meet one of the copyright holders in a bar you are obligated
//  to buy them one pint of beer.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
    self.shareString = [self.shareString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.shareString = [self.shareString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
    NSURL *tweetbotURL = [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///post?text=%@", self.shareString]];
    [[UIApplication sharedApplication] openURL:tweetbotURL];
    
    [self activityDidFinish:YES];
}

@end
