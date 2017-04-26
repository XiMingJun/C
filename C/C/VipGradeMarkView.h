//
//  VipGradeMarkView.h
//  TestDemo
//
//  Created by wangjian on 2017/4/13.
//  Copyright © 2017年 com.qhfax. All rights reserved.
// 用户Vip 等级标识

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VipGradeType) {
    VipGradeType_Vip1 = 0,
    VipGradeType_Vip2,
    VipGradeType_Vip3,
    VipGradeType_Vip4,
    VipGradeType_Vip5,
    VipGradeType_Vip6,
};//用户vip等级枚举类型

@interface VipGradeMarkView : UIView
/**等级标题数组*/
@property (nonatomic,retain)NSMutableArray *gradeArray;
/**Vip等级*/
@property (nonatomic,assign)VipGradeType vipGrade;
/**vip 进度,0-1*/
@property (nonatomic,assign)float vipProgressValue;
@end
