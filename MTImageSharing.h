//
//  MTImageSharing.h
//  MTImageSharing
//
//  Created by Mahesh Dhumpeti on 29/12/15.
//  Copyright © 2015 Mahesh Dhumpeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

@class MTImageSharing;

@protocol MTImageSharingDelegate <NSObject>

- (void)imageSharingProgress:(MTImageSharing*)imageSharing progress:(float)progress;
- (void)imageSharingAborted:(MTImageSharing*)imageSharing;
- (void)imageSharingError:(MTImageSharing*)imageSharing error:(NSError *)error;
- (void)imageSharingUploadDone:(MTImageSharing*)imageSharing url:(NSURL*)url;
- (void)imageSharingDownloadDone:(MTImageSharing*)imageSharing image:(UIImage *)image;

@end

@interface MTImageSharing : NSObject<NSURLConnectionDataDelegate> {
@private
    NSInteger totalBytesExpectedToRead;
    id<MTImageSharingDelegate> delegate;
    long statusCode;
}

+ (id)imageSharingUpload:(NSURL*)url image:(UIImage*)image delegate:(id<MTImageSharingDelegate>)delegate userInfo:(id)userInfo;
+ (id)imageSharingDownload:(NSURL*)url delegate:(id<MTImageSharingDelegate>)delegate userInfo:(id)userInfo;

- (void)cancel;

@property (nonatomic, retain) id userInfo;

@property (nonatomic, readonly, getter=isUploading) BOOL upload;
@property (nonatomic, readonly) NSMutableData* data;
@property (nonatomic, readonly) NSURLConnection* connection;

@end
