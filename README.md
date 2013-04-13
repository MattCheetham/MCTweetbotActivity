# MCTweetbotActivity

`MCTweetbotActivity` is a `UIActivity` subclass that provides an "Open In Tweetbot" action to a `UIActivityViewController`.

![MCTweetbotActivity screenshot](http://f.cl.ly/items/1u1N3v1P0n2L0d0Y2o1W/EB1CC4A9-992A-49D5-BAAE-8855362FA168.png "MCTweetbotActivity screenshot")

## Requirements

- As `UIActivity` is iOS 6 only, so is the subclass.

## Installation

Add the `MCTweetbotActivity.m` and `MCTweetbotActivity.h` files to your project.

## Usage

Simply `alloc`/`init` an instance of `MCTweetbotActivity` and pass that object into the applicationActivities array when creating a `UIActivityViewController`.

```objectivec
NSURL *URL = [NSURL URLWithString:@"http://google.com"];
MCTweetbotActivity *tweetbot = [[MCTweetbotActivity alloc] init];
UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[URL] applicationActivities:@[tweetbot]];
```

Note that you can include the activity in any `UIActivityViewController` and it will only be shown to the user if there is a NSURL or NSString in the activity items.