//
//  ViewController.m
//  ClassArchive
//
//  Created by 黄章成 on 2017/8/10.
//  Copyright © 2017年 黄章成. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "Keychain.h"
#import "Bag.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *filePath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/**************************  UserDefault  **************************************/
//    User *user = [[User alloc] init];
//    user.name = @"Lilei";
//    user.age = 14;
//    user.address = @"北京";

//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
/**************************  Keychain  **************************************/
//    NSLog(@"钥匙串保存----- %d",[Keychain saveValue:user forKey:@"myUser"]);
    
/**************************  自动归档解档  **************************************/    
    Bag *bag = [[Bag alloc] init];
    bag.name = @"Red Bag";
    bag.price = 800;
    
    _filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bag.data"];
    // Encoding
    [NSKeyedArchiver archiveRootObject:bag toFile:_filePath];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
//    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
//    User *user = [Keychain loadValueForKey:@"myUser"];
//    NSLog(@"%@----%zd-----%@",user.name,user.age,user.address);
//    NSLog(@"钥匙串删除------ %d",[Keychain deleteValueForKey:@"myUser"]) ;
//    
//    User *user1 = [Keychain loadValueForKey:@"myUser"];
//    NSLog(@"%@----%zd-----%@",user1.name,user1.age,user1.address);
    
    Bag *decodedBag = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
    NSLog(@"name=%@, price=%f", decodedBag.name, decodedBag.price);
}


@end
