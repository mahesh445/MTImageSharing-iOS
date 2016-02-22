# MTImageSharing-iOS
Downloading and Uploading of images between server and mobile app

=============================================================================================
//******************************** PRE INTEGRATION NOTES **********************************//
=============================================================================================

This software can be used and modified according to usability. No License is required and verison support is given from iOS 6.0 which supports to lower iOS versions also.

"To use this software in a project that developed under ARC, you don't allow ARC feature to MTImageSharing.m file by adding compiler flag '-fno-objc-arc' in Compile Sources under Build Phases. If it is non ARC project then just drag and drop these two files in your project bundle and run."

=============================================================================================
//********************************* INTERACTIVE METHODS ***********************************//
=============================================================================================

/**
The below methods to create sharing connection between server and application
*/
+ (id)imageSharingUpload:(NSURL*)url image:(UIImage*)image delegate:(id<MTImageSharingDelegate>)delegate userInfo:(id)userInfo
+ (id)imageSharingDownload:(NSURL*)url delegate:(id<MTImageSharingDelegate>)delegate userInfo:(id)userInfo

=============================================================================================
//****************************** MTSharingDelegate METHODS *******************************//
=============================================================================================

/**
The below are required protocals and let the user about the progress of sharing
*/
- (void)imageSharingProgress:(MTImageSharing*)imageSharing progress:(float)progress
- (void)imageSharingAborted:(MTImageSharing*)imageSharing
- (void)imageSharingError:(MTImageSharing*)imageSharing error:(NSError *)error
- (void)imageSharingUploadDone:(MTImageSharing*)imageSharing url:(NSURL*)url
- (void)imageSharingDownloadDone:(MTImageSharing*)imageSharing image:(UIImage *)image

=============================================================================================
=============================================================================================
=============================================================================================