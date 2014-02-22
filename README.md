# MCTweetbotActivity

MCTweetbotActivity is a `UIActivity` subclass that provides an "Open In Tweetbot" action to a `UIActivityViewController`.

![MCTweetbotActivity screenshot](http://f.cl.ly/items/2h3A3b3Q2x422F2p2t24/photo.PNG "MCTweetbotActivity screenshot")

## Requirements

- iOS 6.0 or greater

## Installation

Add the `MCTweetbotActivity.m`, `MCTweetbotActivity.h` and `MCTweetbotActivityMedia.xcassets` files to your project.

## Usage

Simply create an instance of `MCTweetbotActivity` and pass that object into the applicationActivities array when creating a `UIActivityViewController`.

```objectivec
NSURL *URL = [NSURL URLWithString:@"http://google.com"];
MCTweetbotActivity *tweetbot = [MCTweetbotActivity new];
UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[URL] applicationActivities:@[tweetbot]];
```

Note that you can include the activity in any `UIActivityViewController` and it will only be shown to the user if there is a NSURL or NSString in the activity items.