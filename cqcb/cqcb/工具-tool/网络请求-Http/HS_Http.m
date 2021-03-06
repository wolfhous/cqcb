//
//  HS_Http.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "HS_Http.h"
#import "AFNetworking.h"
@implementation HS_Http

+(void)hs_postAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id responseObject))success error:(void(^)(id error))iserror{
    [self hs_isPost:YES withBoolClear:NO withAPIName:apiName parameters:parameters succes:^(id responseObject) {
        success(responseObject);
    } error:^(id error) {
        iserror(error);
    }];
}

+(void)hs_postClearAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id responseObject))success error:(void(^)(id error))iserror{
    [self hs_isPost:YES withBoolClear:YES withAPIName:apiName parameters:parameters succes:^(id responseObject) {
        success(responseObject);
    } error:^(id error) {
        iserror(error);
    }];
}



+(void)hs_postBoolClear:(BOOL)hideHUD withAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id responseObject))success error:(void(^)(id error))iserror{
    [self hs_isPost:YES withBoolClear:hideHUD withAPIName:apiName parameters:parameters succes:^(id responseObject) {
        success(responseObject);
    } error:^(id error) {
        iserror(error);
    }];
}

+(void)hs_getAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id dic))success error:(void(^)(id error))iserror{
    [self hs_isPost:NO withBoolClear:NO withAPIName:apiName parameters:parameters succes:^(id responseObject) {
        success(responseObject);
    } error:^(id error) {
        iserror(error);
    }];
}


+(void)hs_getClearAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id dic))success error:(void(^)(id error))iserror{
    [self hs_isPost:NO withBoolClear:YES withAPIName:apiName parameters:parameters succes:^(id responseObject) {
        success(responseObject);
    } error:^(id error) {
        iserror(error);
    }];
    
}



+(void)hs_isPost:(BOOL)isPost
     withBoolClear:(BOOL)hideHUD
       withAPIName:(NSString *)apiName
        parameters:(NSMutableDictionary *)parameters
            succes:(void(^)(id responseObject))success
             error:(void(^)(id error))iserror{
    
    //检测网络
    if (![HSManager hs_isExistenceNetwork]) {
        DLog(@"没有连接网络");

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        // Set the custom view mode to show any view.
        hud.mode = MBProgressHUDModeCustomView;
        // Set an image view with a checkmark.
        UIImage *image = [[UIImage imageNamed:@"hs_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        hud.square = YES;
        // Optional label text.
//        hud.labelText = NSLocalizedString(@"网络连接失败", @"HUD done title");
        hud.labelText = @"网络连接失败";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2.f];
        
    }
    
    
    
    
    if (parameters == nil) {
        parameters = [NSMutableDictionary dictionary];
    }
    parameters[@"timer"] = [HSManager hs_getTimeStamp];
    
    DLog(@"\n【请求接口】\n%@\n【请求参数】\n%@",apiName,parameters);
    
    //1创建AFHTTPSessionManager 请求管理集
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //取消所有其他请求
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //2设置超时时间
    manager.requestSerializer.timeoutInterval = 5;
    //添加一个返回格式解析
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html",@"application/javascript"]];
    
    
    //2.1顶栏状态转圈图形
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    
    
    if (isPost) {
        //4开始请求
        [manager POST:apiName parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            //请求进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//顶栏状态转圈图形
            
            //判断返回状态码
//            [[self alloc]judgeCode:responseObject];
            //请求成功返回数据
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//顶栏状态转圈图形
        
            
            DLog(@"%@",error);
            if (error.code == NSURLErrorCancelled) {
                DLog(@"取消了%@接口的请求",apiName);
            }else if (error.code == NSURLErrorTimedOut){
                DLog(@"请求超时");
            }else if (error.code == NSURLErrorBadServerResponse){
                DLog(@"【这是一个坏的（不正确的）接口请求地址】");
            }
            
            //请求失败
            iserror(error);
            
        }];

    }else{
        //4开始请求
        [manager GET:apiName parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            //请求进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//顶栏状态转圈图形
            
            //判断返回状态码
            [[self alloc]judgeCode:responseObject];
            //请求成功返回数据
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];//顶栏状态转圈图形
            DLog(@"%@",error);
            if (error.code == NSURLErrorCancelled) {
                DLog(@"取消了%@接口的请求",apiName);
            }else if (error.code == NSURLErrorTimedOut){
                DLog(@"请求超时");
            }else if (error.code == NSURLErrorBadServerResponse){
                DLog(@"【这是一个坏的（不正确的）接口请求地址】");
            }
            //请求失败
            iserror(error);
        }];
    }
}



-(void)judgeCode:(id)responseObject{
    if ([responseObject[@"code"] isEqualToString:@"1111"]) {
        DLog(@"正常");
    }else{
        DLog(@"不正常========%@",responseObject[@"desc"]);
    }
}




@end
