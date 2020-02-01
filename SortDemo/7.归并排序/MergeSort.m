//
//  MergeSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "MergeSort.h"

@implementation MergeSort
+(void)test
{
    [[MergeSort new] test1];
}

 
-(void)test1
{
    NSMutableArray *arr =[NSMutableArray arrayWithArray: @[@(13),@(222),@(28),@(333)]];
    [self mergeSort:arr isFromMaxToMin:NO];
    NSLog(@"归并排序的结果 %@",arr);
}

/**
 归并排序的基本思想：
    归并排序的递归方式就类似于一个完全二叉树。
    把数组每次分成左右两组，然后左右两组递归分组操作，左右l两组分别又再一次分为左右两组。
    直到子树只有一个数为止。
    然后把子树从下向上进行比较，先从最底层只有一个数的子树进行左右比较。
    如果发现顺序不对就交换。
    交换后又对子树的父节点层左右子树进行比较。
    此时的比较方式与只有一个数的子树不一样。
    因为现在比较的左右子树都是数组。
    首先需要创建一个新数组，这个新数组是用于保存2个数组比较排序后的正确顺序，
    需要先用左右数组首个数比较找到左右两组中最小的元素并把最小元素加入新数组中，
    然后再用另一个较大的元素与较小元素的其他数进行比较，
    直到找到下一个较小的元素加入新数组中，
    这样重复比较，直到比较到第一个数组中所有元素比较完成后，
    把另一个数组x剩余的数按照顺序加入到新数组中，
    此时新数组中就包含了2个比较数组的所有元素。
    把新数组与比较的左右数组在原数组中的为孩子元素进行替换。
    这样重复操作，直到没有上层了。
    此时数组就完成了排序。
 */
/**
 对数组进行归并排序
@param array 需要进行排序的数组
@param isFromMaxToMin 数组排序的方式，yes 从大到小排序，no 从小到大
*/
-(void)mergeSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
//    忽略操作
    if (!array || array.count < 2) {
        return;
    }
    
//    进行归并排序
    [self mergeSort:array leftIndex:0 rightIndex:array.count - 1];
}

/**
 归并排序之左右分组递归方法
 @param array 需要排序的数组
 @param left 需要分组的数据最左边下坐标
 @param right 需要分组的数据最右边下坐标
 
 */
-(void)mergeSort:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
//    如果left下坐标不小于right下坐标，说明已经是最底层子树。只有左右子树只有1个元素了，不需要再分组
    if(left < right)
    {
//        mind 是把数组左右分组后，右边数组第一个元素的下坐标。如果数组长度是单数，则把最中间的数放在右边数组中
        NSInteger mind = (left + right) % 2 > 0 ? (left + right) / 2 + 1 : (left + right ) / 2;
//        循环递归分组
        [self mergeSort:array leftIndex:left rightIndex:mind  - 1];
        [self mergeSort:array leftIndex:mind rightIndex:right];
//        分组完成后对数组进行比较排序
        [self merge:array leftIndex:left rightIndex:right mindIndex:mind];
    }
}

/**
归并排序的核心比较方法
@param array 需要排序的数组
@param left 比较的左边数组的首位元素下坐标
@param right  比较的右边数组的最末元素尾下标
@Param mind  比较的右边数组的首位元素下坐标

*/
-(void)merge:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right mindIndex:(NSInteger)mind
{
//    left == mind 说明这是最下层子树
    if (right == mind)
    {
        NSInteger leftValue = [[array objectAtIndex:left] integerValue];
        NSInteger rightValue = [[array objectAtIndex:right] integerValue];
        if ( leftValue > rightValue) {
            [array exchangeObjectAtIndex:left withObjectAtIndex: right];
        }
    } else {
//        非最下层子树，需要先创建一个新的数组，来保存正确排序的结果
        NSMutableArray * newArray = [NSMutableArray arrayWithCapacity:array.count];
//        临时记录原mind值，用作比较
        NSInteger mind_x = mind;
//        临时记录原left值，用作比较
        NSInteger left_x = left;
//        循环操作，直到左右两个数组中有一方的所有元素都比较完成
        while (mind_x <= right && left_x < mind) {
            NSInteger leftXValue = [[array objectAtIndex:left_x] integerValue];
            NSInteger mindXValue = [[array objectAtIndex:mind_x ] integerValue];
//            如果左边元素大于右边元素 那么就把小的元素加入新数组中
            if (leftXValue > mindXValue) {
                [newArray addObject:[array objectAtIndex:mind_x]];
//                然后把mind_x 加1，让较大的y左右元素与下一个右边元素进行比较
                mind_x ++;
            } else {
//             如果左边元素小于右边元素 那么就把小的元素加入到新数组中
                [newArray addObject:[array objectAtIndex:left_x]];
//                然后把left_x 加1 ，让较大的右边元素与下一个左边元素进行比较
                left_x ++;
            }
        }
//        如果左边的元素没哟比较完，那么把剩下的左边元素依次加入到新数组中
        while (left_x < mind){
            [newArray addObject:[array objectAtIndex:left_x]];
            left_x ++;
        }
//        如果右边的元素没有比较完，那么把剩下的右边元素依次加入到新数组中
        while (mind_x <= right) {
            [newArray addObject:[array objectAtIndex:mind_x]];
            mind_x ++;
        }
        
        NSRange range = NSMakeRange(left, (right - left) + 1);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [array replaceObjectsAtIndexes:indexSet withObjects:newArray];
    }
//
    
}
@end
