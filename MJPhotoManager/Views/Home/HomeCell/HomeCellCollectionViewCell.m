//
//  HomeCellCollectionViewCell.m
//  MJPhotoManager
//
//  Created by 马家俊 on 17/5/16.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "HomeCellCollectionViewCell.h"

@implementation HomeCellCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.homeCellLab = [[UILabel alloc]initWithFrame:self.frame];
        self.homeCellLab.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1];
        self.homeCellLab.textAlignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"20170516"];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:16.0]
                              range:NSMakeRange(0, 4)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor redColor]
                              range:NSMakeRange(0, 4)];
        self.homeCellLab.attributedText = AttributedStr;
        [self.contentView addSubview:self.homeCellLab];
    }
    return self;
}
@end
