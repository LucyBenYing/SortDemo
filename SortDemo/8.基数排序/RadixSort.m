//
//  RadixSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "RadixSort.h"

@implementation RadixSort
+(void)test
{
    [[RadixSort new] test1];
}

 
-(void)test1
{
    NSMutableArray *arr =[NSMutableArray arrayWithArray: @[@"13",@"222",@"28",@"333"]];
    [self radixSort:arr isFromMaxToMin:NO];
    
}

/**
 基数排序：
    基本思路
        基数排序最核心思想就是入桶。
    基数排序主要的步骤有3步
    1.找到元素组中最大的元素
    2.根据1找到的元素，把原数组中所有元素按照最大元素补位。
        例如： 最大元素是1001，而原数组中有一个元素为2，那么把2按照最大元素补位，就是把2的长度补到与最大元素长度一样，前面补0，
        2补位后就变成了0002.
    3.创建桶。因为数字是从0-9的。一共10个桶。
    把补位后的数组从个位、十位、百位。。。以此类推。
    进行每一位的单独排序，
    从桶0开始，只要有比较的位数是0，就把元素放入同0中。
    个位比较完了就比较十位，一直比较到最大位。
    最后数组就已经成为一个有序数组了。
 
 */
/**
 对数组进行基数排序
@param array 需要进行排序的数组
@param isFromMaxToMin 数组排序的方式，yes 从大到小排序，no 从小到大
*/
-(void)radixSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
//    忽略操作
    if(!array || array.count < 2 ){
        return;
    }
//    进行基数排序
//1.获取数组中最大的元素
    NSString *maxNumber = [self getMaxNumberInArray:array];
//    2.根据最大元素对数组进行补位
    [self complementWithArray:array maxNumber:maxNumber];
//    3.入桶比较排序
    array = [self radixSort:array maxNumber:maxNumber];
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
                 NSLog(@"基数排序结果：%@",array);
}
//从数组中获取最大值
-(NSString *)getMaxNumberInArray:(NSMutableArray *)array
{
    NSString *maxNumber = @"0";
    for (NSString *number in array) {
        if ([maxNumber integerValue ] < [number integerValue]) {
            maxNumber = [number copy];
        }
    }
    return maxNumber;
}

/**
 根据最大元素，对数组中所有元素进行补位
    @param array 需要补位的数组
 @oparam maxNumber 最大元素，用作补位的参照
 */
-(void)complementWithArray:(NSMutableArray *)array maxNumber:(NSString *)maxNumber
{
//    因为元素都是用的NSString，所以补位采用该方法。
//    如果元素是int等可以不用进行这种补位。
//    在比较的时候判断下长度，长度不够直接补0比较即可。
    for (NSInteger j = 0; j < array.count; j++) {
        NSString *number = [array objectAtIndex:j];
        if (number.length < maxNumber.length) {
            NSInteger len = maxNumber.length - number.length;
            NSString *str = @"";
            for (int i = 0 ; i < len; i ++) {
                str = [str stringByAppendingString:@"0"];
            }
            array[j] = [NSString stringWithFormat:@"%@%@",str,number];
        }
    }
}

/**
 技术排序的核心代码
 @param array 原数组
 @param maxNumber 原数组中最大的元素
 @return 返回一个排序完成的新数组
 */
-(NSMutableArray *)radixSort:(NSMutableArray *)array maxNumber:(NSString *)maxNumber
{
//    copy一份原数组，arraycopy后面主要是用来记录重新排序后的最新数组
    NSMutableArray *arrayCopy = [array mutableCopy];
//    根据最大元素判断需要比较多少位
    for (NSInteger i = 0; i < maxNumber.length; i++) {
//        创建装桶的数组
        NSMutableArray *bucketArray = [NSMutableArray arrayWithCapacity:10];
//        0-9 一共10 个桶
        for (NSInteger j = 0; j < 10; j ++) {
//             桶 当前需要放入的元素根据j定
            NSMutableArray *buket = [NSMutableArray array];
//            遍历数组，找到相应位数的元素是否该放入当前桶
            for (NSInteger m = 0; m < array.count; m ++) {
//                取出数组每个元素
                NSString *numer = [arrayCopy objectAtIndex:m];
//                取出需要比较的位所对应的值
                NSInteger num = [[numer substringWithRange:NSMakeRange(numer.length - 1 - i, 1)] integerValue];
//                如果比较的位所对应的值跟桶的值一样，就把改元素加入对应桶中
                if (num == j) {
                    [buket addObject:numer];
                }
            }
//            如果桶中有元素才把桶加入存放桶的数组
            if (buket.count > 0) {
//                把桶加入数组
                [bucketArray addObject:buket];
            }
        }
//        移除上一次记录的值
        [arrayCopy removeAllObjects];
//        把根据桶排序好的数组放入arrayCopy中，直到每一位都比较完，那么数组已经排序完成了
        for (NSMutableArray * obj in  bucketArray) {
            for (NSString * str in obj) {
                [arrayCopy addObject:str];
            }
        }
    }
    return arrayCopy;
}

@end
