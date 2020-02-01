//
//  BubbleSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort
+(void)test
{
    BubbleSort *bulle = [BubbleSort new];
    [bulle test1];
}

#pragma mark - 1. 冒泡排序
-(void)test1
{
    NSMutableArray *arr =[NSMutableArray arrayWithArray: @[@(13),@(222),@(28),@(333)]];
    NSLog(@"冒泡排序 1 %@", [self bubbleSort: arr  isFromMaxToMin:NO]);
}
/**
 1.冒泡排序
 基本思想： 从头到尾，相邻的两个元素进行比较，如果出现反序就交换。否则就执行下一次比较。
 时间复杂度：
 最短时间复杂度为o(n) ,当数组本身是正序排列时，无需交换
 最长时间复杂度为o(n2),当数组本身是反序排列时，需要每两个数都进行交换
 */
 
/**
 冒泡排序
   @param array 需要排序的数组
   @param isFromMaxToMin Yes 表示从大到小排序 NO 表示从小到大
   @return 选择排序后的结果
*/
-(NSMutableArray *)bubbleSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    //标记最外层循环的循环次数
       NSUInteger count = 0;
       //标记下 坐标交换次数
       NSUInteger exchangeCount = 0;
//    最外层的循环次数取决于数组的长度
//    冒泡排序中，最外层的每一循环都能在未排列好的数（没有找到自己在数组中准确位置的数）中找打最大的那个数
//    数组c的长度就是最层的循环次数
    for (int i = 0; i < array.count - 1; i ++) {
//        最外层循环次数累加
        count ++;
//        标记是否已无需排序
//        当某一次最外层（最外层是指 i这一层）循环没有产生任何一次交换时，则说明该数组已经排序成功
        BOOL isFinish = YES;
//        数组的首下标是从0开始
//        最外层的每一次循环中，最内层都需要把数组中所有数据进行两两比较
        for (int j = 0; j < array.count - i - 1; j++) {
            NSInteger a = [array[j] intValue];
            NSInteger b = [array[j + 1] intValue];
//            判断是否从大到小排序还是从小到大排序
            if (isFromMaxToMin) {
//                冒泡排序的核心是相邻的两个数据进行比较，所以比较的数一定是相邻的
                if (b > a) {
//                    进行交换
                    [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//                    交换次数累加
                    exchangeCount ++;
//                    如果产生交换，z说明还未排序成功
                    isFinish = NO;
                }
            } else {
                if (b < a) {
                    [array exchangeObjectAtIndex:j withObjectAtIndex:j +1 ];
                    exchangeCount ++;
                    isFinish = NO;
                }
            }
        }
//        已经排序成功则结束最外层的循环
        if (isFinish) {
            break;
        }
    }
    NSLog(@"冒泡排序1--最外层循环次数 = %lu",count);
     NSLog(@"冒泡排序1--交换次数%lu",exchangeCount);
    
    return array;
}


@end
