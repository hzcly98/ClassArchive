//
//  User.m
//  ClassArchive
//
//  Created by 黄章成 on 2017/8/10.
//  Copyright © 2017年 黄章成. All rights reserved.
//

#import "User.h"

@implementation User

// 归档时调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    NSLog(@"%s",__func__);
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.address forKey:@"address"];
}

// 接档时调用
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    NSLog(@"%s",__func__);
    
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
    }
    return self;
}

@end
