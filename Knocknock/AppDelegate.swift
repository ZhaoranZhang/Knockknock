//
//  AppDelegate.swift
//  Knocknock
//
//  Created by Wenxiang Deng on 7/1/16.
//  Copyright © 2016 Wenxiang Deng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        loadHTTPCookies()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        saveHTTPCookies()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveHTTPCookies()
    }
    
    func loadHTTPCookies() {
        if let cookieData = NSUserDefaults.standardUserDefaults().objectForKey("cookies") as? NSData {
            if let cookies = NSKeyedUnarchiver.unarchiveObjectWithData(cookieData) as? [NSHTTPCookie] {
                for cookie in cookies {
                    NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookie)
                }
            }
        }
    }
    
    func saveHTTPCookies() {
        if let cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies {
            let data: NSData = NSKeyedArchiver.archivedDataWithRootObject(cookieJar)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "cookies")
        }
        
    }
    
    //    -(void)loadHTTPCookies
    //    {
    //    NSMutableArray* cookieDictionary = [[NSUserDefaults standardUserDefaults] valueForKey:@"cookieArray"];
    //
    //    for (int i=0; i < cookieDictionary.count; i++)
    //    {
    //    NSMutableDictionary* cookieDictionary1 = [[NSUserDefaults standardUserDefaults] valueForKey:[cookieDictionary objectAtIndex:i]];
    //    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDictionary1];
    //    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    //    }
    //    }
    //
    //    -(void)saveHTTPCookies
    //    {
    //    NSMutableArray *cookieArray = [[NSMutableArray alloc] init];
    //    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
    //    [cookieArray addObject:cookie.name];
    //    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    //    [cookieProperties setObject:cookie.name forKey:NSHTTPCookieName];
    //    [cookieProperties setObject:cookie.value forKey:NSHTTPCookieValue];
    //    [cookieProperties setObject:cookie.domain forKey:NSHTTPCookieDomain];
    //    [cookieProperties setObject:cookie.path forKey:NSHTTPCookiePath];
    //    [cookieProperties setObject:[NSNumber numberWithUnsignedInteger:cookie.version] forKey:NSHTTPCookieVersion];
    //    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    //
    //    [[NSUserDefaults standardUserDefaults] setValue:cookieProperties forKey:cookie.name];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    //
    //    }
    //
    //    [[NSUserDefaults standardUserDefaults] setValue:cookieArray forKey:@"cookieArray"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    //    }
}

