//
//  APIManager.m
//  ProVital
//
//  Created by Bob de Graaf on 04-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "APIManager.h"
#import "AFNetworking.h"
#import "NSObject+Helper.h"

#define kBaseURL            @"http://staging.neocate.com/app/"

@interface APIManager ()
{
    
}

@end

@implementation APIManager

#pragma mark - API Manager & Parameters

+(AFHTTPSessionManager *)managerForCall:(NSString *)call
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"json/application", @"text/x-json", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [manager.requestSerializer setTimeoutInterval:10.0f];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    
    return manager;
}

+(NSMutableDictionary *)getFinalParametersForParameters:(NSDictionary *)parameters
{
    NSMutableDictionary *finalParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    //Add default parameter?
    return finalParameters;
}

#pragma mark - API Calls

+(void)getAPICall:(NSString *)call success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self getAPICall:call parameters:nil checkObject:nil success:success failure:failure];
}

+(void)postAPICall:(NSString *)call success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self postAPICall:call parameters:nil checkObject:nil success:success failure:failure];
}

+(void)getAPICall:(NSString *)call checkObject:(NSString *)object success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self getAPICall:call parameters:nil checkObject:object success:success failure:failure];
}

+(void)postAPICall:(NSString *)call checkObject:(NSString *)object success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self postAPICall:call parameters:nil checkObject:object success:success failure:failure];
}

+(void)deleteAPICall:(NSString *)call parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self deleteAPICall:call parameters:parameters checkObject:nil success:success failure:failure];
}

+(void)putAPICall:(NSString *)call parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self putAPICall:call parameters:parameters checkObject:nil success:success failure:failure];
}

+(void)getAPICall:(NSString *)call parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self getAPICall:call parameters:parameters checkObject:nil success:success failure:failure];
}

+(void)postAPICall:(NSString *)call parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self postAPICall:call parameters:parameters checkObject:nil success:success failure:failure];
}

+(void)getAPICall:(NSString *)call parameters:(id)parameters checkObject:(NSString *)object success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    DLog(@"API-Call: %@, parameters: %@", call, parameters);
    AFHTTPSessionManager *manager = [self managerForCall:call];
    
    NSMutableDictionary *finalParameters = [self getFinalParametersForParameters:parameters];
    [manager GET:call parameters:finalParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"GET API-Call success: %@, response: %@", call, responseObject);
        
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            if(object.length && !responseObject[object]) {
                DLog(@"Check object: '%@', not found in responseObject: %@", object, responseObject);
                failure([NSError errorWithDomain:@"API" code:0 userInfo:@{@"description":@"checkObject not found"}]);
                return;
            }
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self logAPIError:task error:error];
        failure(error);
    }];
}

+(void)postAPICall:(NSString *)call parameters:(id)parameters checkObject:(NSString *)object success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    DLog(@"API-Call: %@, parameters: %@", call, parameters);
    AFHTTPSessionManager *manager = [self managerForCall:call];
    NSMutableDictionary *finalParameters = [self getFinalParametersForParameters:parameters];
    [manager POST:call parameters:finalParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"POST API-Call success: %@, response: %@", call, responseObject);
        
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            if(object.length && !responseObject[object]) {
                DLog(@"Check object: '%@', not found in responseObject: %@", object, responseObject);
                failure([NSError errorWithDomain:@"API" code:0 userInfo:@{@"description":@"checkObject not found"}]);
                return;
            }
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self logAPIError:task error:error];
        failure(error);
    }];
}

+(void)putAPICall:(NSString *)call parameters:(id)parameters checkObject:(NSString *)object success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    DLog(@"API-Call: %@, parameters: %@", call, parameters);
    AFHTTPSessionManager *manager = [self managerForCall:call];
    NSMutableDictionary *finalParameters = [self getFinalParametersForParameters:parameters];
    [manager PUT:call parameters:finalParameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"PUT API-Call success: %@, response: %@", call, responseObject);
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            if(object.length && !responseObject[object]) {
                DLog(@"Check object: '%@', not found in responseObject: %@", object, responseObject);
                failure([NSError errorWithDomain:@"API" code:0 userInfo:@{@"description":@"checkObject not found"}]);
                return;
            }
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self logAPIError:task error:error];
        failure(error);
    }];
}

+(void)deleteAPICall:(NSString *)call parameters:(id)parameters checkObject:(NSString *)object success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    DLog(@"API-Call: %@, parameters: %@", call, parameters);
    AFHTTPSessionManager *manager = [self managerForCall:call];
    NSMutableDictionary *finalParameters = [self getFinalParametersForParameters:parameters];
    [manager DELETE:call parameters:finalParameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"DELETE API-Call success: %@, response: %@", call, responseObject);
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            if(object.length && !responseObject[object]) {
                DLog(@"Check object: '%@', not found in responseObject: %@", object, responseObject);
                failure([NSError errorWithDomain:@"API" code:0 userInfo:@{@"description":@"checkObject not found"}]);
                return;
            }
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self logAPIError:task error:error];
        failure(error);
    }];
}

#pragma mark - Error logging

+(void)logAPIError:(NSURLSessionDataTask *)task error:(NSError *)error
{
    DLog(@"API Call failure error: %@", error.description);
    DLog(@"API Call failure statuscode: %d", (int)((NSHTTPURLResponse *)task.response).statusCode);
    DLog(@"API Call failure response: %@", task.response);
    
    NSString *errorString = [[NSString alloc] initWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    DLog(@"API CALL failure error string: %@", errorString);
    
    NSDictionary *userinfo = [[NSDictionary alloc] initWithDictionary:error.userInfo];
    if(!userinfo) {
        DLog(@"No user info within the error...");
        return;
    }
    NSError *innerError = [userinfo valueForKey:@"NSUnderlyingError"];
    if(innerError) {
        NSDictionary *innerUserInfo = [[NSDictionary alloc] initWithDictionary:innerError.userInfo];
        if(innerUserInfo) {
            if([innerUserInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey]) {
                NSString *errorString = [[NSString alloc] initWithData:[innerUserInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                DLog(@"Error is 1: %@",errorString);
            }
        }
    } else {
        NSString *errorString = [[NSString alloc] initWithData:[userinfo valueForKey:@"AFNetworkingOperationFailingURLResponseDataErrorKey"] encoding:NSUTF8StringEncoding];
        DLog(@"Error is 2: %@",errorString);
    }
}

@end




























