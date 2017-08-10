//
//  User.h
//  ClassArchive
//
//  Created by 黄章成 on 2017/8/10.
//  Copyright © 2017年 黄章成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *address;

@end
