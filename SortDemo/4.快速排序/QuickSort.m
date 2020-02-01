//
//  QuickSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort

+(void)test
{
    [[QuickSort new] test1];
}

 
-(void)test1
{
    NSMutableArray *arr =[NSMutableArray arrayWithArray: @[@(13),@(222),@(28),@(333)]];
    [self quickSort: arr isFromMaxToMin:NO];
}


//快速排序
/**
 基本思路:
    1.在数组中随机选择一个元素（一般以数组第一个元素开始），当做基准数。
    2.用基准数与数组其他元素进行比较。
    3.将数组中比基准数大的放在右边，比基准数小的放在左边。
    4.然后把数组根据基准数分成2个数组。
    5.称之为基准数左边数组和基准数右边数组。
    6.对左右数组递归重复上面的操作。
    7.直到判断的数组只有一个元素了，就表示排序已经完成。
 
 
 */
/**
 对数组进行快速排序
@param array 需要进行排序的数组
@param isFromMaxToMin 数组排序的方式，yes 从大到小排序，no 从小到大
*/
-(void)quickSort:(NSMutableArray *)array  isFromMaxToMin:(BOOL)isFromMaxToMin
{
    [self quickSort:array leftIndex:0 rightIndex:array.count - 1];
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    NSLog(@"快速排序的结果为：%@",array);
}

-(void)quickSort:(NSMutableArray *)array
       leftIndex:(NSInteger)leftIndex
      rightIndex:(NSInteger)rightIndex
{
//    如果排序长度是1则忽略
    if (rightIndex <= leftIndex) {
        return;
    }
//     i 表示排序开始时的基准数在数组中的下坐标
    NSInteger i = leftIndex;
//    j 表示排序是从i到j结束。 整个排序的长度为j- i，是排序最右边元素的下坐标
    NSInteger j = rightIndex;
//    key是记录比较基准数的值
    NSInteger key = [[array objectAtIndex:i] intValue];
    while (i < j ) {
//        右侧j的值
        NSInteger rightValue = [[array objectAtIndex:j] intValue];
//  当j == i 则说明i已经是i到j这段数组中最小的数。不需要交换 所以 i < j
// 如果当前j下坐标表示的值大于等于基准数，那么就将j比较的下坐标减1，让基准数从右往左依次比较，直到遇到比基准数小的数
        while (i < j && key <= rightValue) {
            j --;
//            更新右侧的值
            rightValue = [[array objectAtIndex:j] intValue];
        }
//         当j == i 则说明i已经是i到j这段数组中最小的数。不需要交换
        if (j != i) {
            [array exchangeObjectAtIndex:j withObjectAtIndex:i];
        }
        NSInteger leftValue = [[array objectAtIndex:i] intValue];
//        如果i+1下坐标表示的值小于基准数，那么就将比较的下坐标加1，让基准数从左往右依次比较，直到遇见比基准数大的值
        while (i < j  && key >= leftValue) {
            i++;
//            更新左侧的值
            leftValue = [[array objectAtIndex:i] intValue];
        }
//         当j == i 则说明i已经是i到j这段数组中最f大的数了。不需要交换
        if(j != i){
            [array exchangeObjectAtIndex:j withObjectAtIndex:i];
        }
    }
//    完成一次基准数的判断排序
    
//    根据当下基准数的下坐标把数组分为左右两部分进行左右两部分的分别递归排序
    [self quickSort:array leftIndex:i + 1 rightIndex:rightIndex];
    [self quickSort:array leftIndex:leftIndex rightIndex:i - 1];
}

@end
