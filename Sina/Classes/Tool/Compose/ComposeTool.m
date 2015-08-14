//
//  ComposeTool.m
//  Sina
//
//  Created by James on 3/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "ComposeTool.h"
#import "HttpTool.h"
#import "ComposeParam.h"
#import "MJExtension.h"
#import "UploadParm.h"
#import "AFNetworking.h"

@implementation ComposeTool

/** 发送文字 */
+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    ComposeParam *parm = [ComposeParam paramter];
    parm.status = status;
    [HttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parm.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/** 发送图片 */
+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    ComposeParam *param = [ComposeParam paramter];
    param.status = status;
    UploadParm *uploadP = [[UploadParm alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    [HttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
