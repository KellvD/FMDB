//
//  FMDBModel.h
//  FMDBD
//
//  Created by changdong on 2019/4/11.
//  Copyright © 2019 baize. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)int ids;

@end

NS_ASSUME_NONNULL_END
