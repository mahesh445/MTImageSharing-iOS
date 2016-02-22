//
//  FirstViewController.m
//  MTImageSharing-iOS
//
//  Created by Mahesh Dhumpeti on 19/02/16.
//  Copyright © 2016 mTuity. All rights reserved.
//

#import "FirstViewController.h"
#import "MTImageSharing.h"

#define kDownloadURL @"https://www.gstatic.com/webp/gallery/3.jpg"

@interface FirstViewController () <MTImageSharingDelegate>
{
    __weak IBOutlet UIButton *linkButton;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIProgressView *progressView;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *keys = [NSArray arrayWithObjects:NSUnderlineStyleAttributeName, nil];
    NSArray *objects = [NSArray arrayWithObjects:[NSNumber numberWithInt:NSUnderlineStyleSingle], nil];
    NSDictionary *linkAttributes = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:kDownloadURL attributes:linkAttributes];
    linkButton.titleLabel.attributedText = attrString;
}

#pragma mark - Actions

- (IBAction)downloadImage:(id)sender
{
    imageView.image = nil;
    progressView.hidden = NO;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    NSURL *url = [NSURL URLWithString:kDownloadURL];
    [self downloadImageFromUrl:url];
    
}

- (void)downloadImageFromUrl:(NSURL *)url
{
    [MTImageSharing imageSharingDownload:url delegate:self userInfo:nil];
}


#pragma mark - MTImageSharingDelegate methods

- (void)imageSharingProgress:(MTImageSharing*)imageSharing progress:(float)progress
{
    progressView.progress = progress;
}

- (void)imageSharingAborted:(MTImageSharing*)imageSharing
{
    progressView.hidden = YES;
    
    [[[UIAlertView alloc] initWithTitle:@"Error!"
                                message:@"Download process aborted.\nPlease check your connection status."
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

- (void)imageSharingError:(MTImageSharing*)imageSharing error:(NSError *)error
{
    progressView.hidden = YES;
    
    [[[UIAlertView alloc] initWithTitle:@"Error!"
                                message:error.localizedDescription
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

- (void)imageSharingUploadDone:(MTImageSharing*)imageSharing url:(NSURL*)url
{}

- (void)imageSharingDownloadDone:(MTImageSharing*)imageSharing image:(UIImage *)image
{
    progressView.hidden = YES;
    imageView.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
