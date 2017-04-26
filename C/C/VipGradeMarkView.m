//
//  VipGradeMarkView.m
//  TestDemo
//
//  Created by wangjian on 2017/4/13.
//  Copyright © 2017年 com.qhfax. All rights reserved.
//

#import "VipGradeMarkView.h"
#import "WJProgressView.h"
#import "Define.h"
@interface VipGradeMarkView ()
/**等级标签数组*/
@property (nonatomic,retain)NSMutableArray *gradeMarkLabelArray;
/**线条数组*/
@property (nonatomic,retain)NSMutableArray *lineArray;
@end
@implementation VipGradeMarkView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
        [self buildUI];
        self.vipGrade = VipGradeType_Vip1;
        _vipProgressValue = 0;
    }
    return self;
}
/**公共参数配置*/
- (void)commonInit{

    NSMutableArray *gradeArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i  < 7; i++) {
        NSString *gradeString = [NSString stringWithFormat:@"V%ld",i];
        NSMutableAttributedString *gradeAttribute = [[NSMutableAttributedString alloc] initWithString:gradeString];
        [gradeAttribute addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, 1)];
        [gradeAttribute addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(1, 1)];
        [gradeArray addObject:gradeAttribute];
    }
    self.gradeArray = gradeArray;
    NSMutableArray *gradeMarkLabelArray = [[NSMutableArray alloc] init];
    NSMutableArray *lineArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < gradeArray.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.attributedText = _gradeArray[i];
        label.textColor  = UIColorFromRGB(0xCCCCCC);
        label.textAlignment = NSTextAlignmentCenter;
        [gradeMarkLabelArray addObject:label];
        [self addSubview:label];
        if (i > 0) {
            WJProgressView *lineView = [[WJProgressView alloc] init];
            lineView.backColor = UIColorFromRGB(0xCCCCCC);
            lineView.progressColor = UIColorFromRGB(0xFFB000);
            [lineArray addObject:lineView];
            [self addSubview:lineView];
        }
    }
    self.gradeMarkLabelArray = gradeMarkLabelArray;
    self.lineArray = lineArray;
}
/**构建视图*/
- (void)buildUI{
    
    float labelWidth = 20;
    float labelHeight = 20;
    float originY = (self.frame.size.height - labelHeight)/2;
    float integralH = (self.frame.size.width - labelWidth * _gradeArray.count)/(_gradeArray.count + 1);//水平间距
    float lineWidth = (integralH - 7*2);//线条宽度
    float lineHeight = 4;//线条高度
    float lineOriginY = (self.frame.size.height - lineHeight)/2;
    for (NSInteger i = 0; i < _gradeArray.count; i++) {
        UILabel *titleLabel = _gradeMarkLabelArray[i];
        float originX = integralH *(i + 1) + labelWidth* i;
        titleLabel.frame = CGRectMake(originX, originY, labelWidth, labelHeight);
        if (i < _gradeArray.count - 1) {
            WJProgressView *lineView = _lineArray[i];
            float lineOriginX = originX + labelWidth + 7;
            lineView.frame = CGRectMake(lineOriginX, lineOriginY, lineWidth, lineHeight);
            [lineView resetSubViews];
            lineView.progressShape = WJProgressViewLineShape;
//            lineView.backColor =  UIColorFromRGB(0xCCCCCC);

            lineView.layer.cornerRadius = 2;
            lineView.clipsToBounds = YES;
        }
    }
}
/**刷新vip等级视图*/
- (void)refreshVipGradeView{

    for (NSInteger i = 0; i < _gradeMarkLabelArray.count; i++) {
        UILabel *titleLabel = _gradeMarkLabelArray[i];
        if (i <= _vipGrade) {
            titleLabel.textColor = UIColorFromRGB(0xFFB000);
        }
        else{
            titleLabel.textColor = UIColorFromRGB(0xCCCCCC);
        }
        }
    
    for (NSInteger i = 0 ; i < _vipGrade; i++) {

        if (_vipGrade == VipGradeType_Vip6) {
            //最高等级
            WJProgressView *lineView = _lineArray[i];
            lineView.progress = 100;
            [lineView drawprogressValueWithAnimation:NO];
        }
        else if (_vipGrade == VipGradeType_Vip1) {
        //最低等级
            WJProgressView *lineView = _lineArray[i];
//            lineView.backgroundColor = UIColorFromRGB(0xCCCCCC);
        }
        else{
            WJProgressView *lineView = _lineArray[i];
//            lineView.backgroundColor = UIColorFromRGB(0xFFB000);
            lineView.progress = 100;
            [lineView drawprogressValueWithAnimation:NO];

        }
    }
    
    if (_vipGrade > VipGradeType_Vip1 && _vipGrade < VipGradeType_Vip6) {
        WJProgressView *progressLine = _lineArray[_vipGrade];
//        progressLine.backgroundColor = [UIColor greenColor];
        progressLine.progress = _vipProgressValue * 100;
        [progressLine drawprogressValueWithAnimation:YES];

    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setGradeArray:(NSMutableArray *)gradeArray{

    if (gradeArray.count <= 0) {
        return;
    }
    _gradeArray = gradeArray;
}
- (void)setGradeMarkLabelArray:(NSMutableArray *)gradeMarkLabelArray{

    if (gradeMarkLabelArray.count <= 0) {
        return;
    }
    _gradeMarkLabelArray = gradeMarkLabelArray;
}
- (void)setLineArray:(NSMutableArray *)lineArray{

    if (lineArray.count <= 0) {
        return;
    }
    _lineArray = lineArray;
    
}
- (void)setVipGrade:(VipGradeType)vipGrade{

    if (vipGrade < VipGradeType_Vip1 || vipGrade > VipGradeType_Vip6) {
        return;
    }
    _vipGrade = vipGrade;
    [self refreshVipGradeView];
}
- (void)setVipProgressValue:(float)vipProgressValue{

    if (vipProgressValue < 0  && vipProgressValue > 1) {
        return;
    }
    _vipProgressValue = vipProgressValue;
    [self refreshVipGradeView];
}
@end
