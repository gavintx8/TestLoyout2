//
//  GCPayBankItem.h
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface GPayBankItem : NSObject

@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *image;
@property (nonatomic , strong) NSDictionary *paynumber;
@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic , strong) NSString *sid;
@property (nonatomic , strong) NSString *type;

@end
