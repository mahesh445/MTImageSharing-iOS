//
//  SecondViewController.m
//  MTImageSharing-iOS
//
//  Created by Mahesh Dhumpeti on 19/02/16.
//  Copyright © 2016 mTuity. All rights reserved.
//

#import "SecondViewController.h"
#import "MTImageSharing.h"

#define kUploadURL @"http://172.16.1.151/php/uploadimage.php"

@interface SecondViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MTImageSharingDelegate>
{
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIProgressView *progressView;
}

@property (nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Actions

- (IBAction)pickImage:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:NULL];
}

- (IBAction)upload:(id)sender
{
    NSURL *url = [NSURL URLWithString:kUploadURL];
    UIImage *img = imageView.image;
    if (img) {
        progressView.hidden = NO;
        [MTImageSharing imageSharingUpload:url image:img delegate:self userInfo:nil];
    }
}

- (void)uploadImage:(UIImage *)image toUrl:(NSURL *)url
{
    [MTImageSharing imageSharingUpload:url image:image delegate:self userInfo:nil];
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
                                message:@"Upload process aborted.\nPlease check your connection status."
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
{    
    progressView.hidden = YES;
}

- (void)imageSharingDownloadDone:(MTImageSharing*)imageSharing image:(UIImage *)image
{}

#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    imageView.image = image;
    
    [self finishAndUpdate];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    imageView.image = image;
    
    [self finishAndUpdate];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self finishAndUpdate];
}

- (void)finishAndUpdate
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.imagePickerController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
