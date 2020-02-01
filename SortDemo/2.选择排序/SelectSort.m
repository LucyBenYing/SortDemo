//
//  SelectSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "SelectSort.h"

@implementation SelectSort


+(void)test
{
    [[SelectSort new] testSelect];
}

#pragma mark - 2选择排序


-(void)testSelect
{
    NSArray *arr = @[@(13),@(222),@(28),@(333)];
    
    NSLog(@"选择排序 1 %@",[self selectSort: [NSMutableArray arrayWithArray:arr]
                                                     isFromMaxToMin:NO]);
   
}

/**
 2.选择排序
    基本思想：从数组第一个下坐标一直比较到最后一个下坐标。每一次的外层循环都能确定一个下坐标的数。
 当次循环把最终记录的下坐标数与当前的循环次数所对应的首坐标进行交换。
 时间复杂度： 固定的o(n2) n的平方

 */
/**
  2. 选择排序
    @param array 选择排序
    @param isFromMaxToMin Yes 表示从大到小排序 NO 表示从小到大
    @return 选择排序后的结果
 */
-(NSMutableArray *)selectSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    //标记最外层循环的循环次数
    NSUInteger count = 0;
    //标记下 坐标交换次数
    NSUInteger exchangeCount = 0;
//    选择排序的最外层循环次数是固定的，取决于数组的长度
//    选择排序是一个比较特殊的排序，他的时间复杂度是固定的O(n2)
    for (int i = 0; i < array.count; i++) {
//         累加最外层执行次数
        count ++;
        
//        创建一个新数组用于存放每次需要比较的数据
        NSMutableArray *newArray = [NSMutableArray new];
//        最外层 每次都能正确排序出一个数的位置，所以已经排序好的位置不需要在加入比较
//        j = i + 1 的原因是，排除拿出来比较的第一个数，减少计算次数
        for(int j = i + 1;  j < array.count ; j ++){
            [newArray addObject:array[j]];
        }
//        取出需要比较的数
        int a  = [array[i] intValue];
//       minIndex用于记录每轮比较的数据中最大数据的下坐标
        int minIndex = i;
//        进行比较
        for(int m = 0; m < newArray.count; m ++){
//            从新的数据源中取出比较的数
            int b = [newArray[m] intValue];
//            判断是从大到小排序 还是从小到大排序
            if(isFromMaxToMin){
                if (b > a) {
//                    记录下最大值
                    a = b;
// minIndex = i + m + 1 之所以加1 谁因为newArray中已经排除了第一个比较的数，所以下标相比于最外层array少了1
                    minIndex = i + m + 1;
//                    累加交换次数
                    exchangeCount ++;
                }
            } else {
                if (b < a ) {
                    a = b;
                    minIndex = i + m + 1;
                    exchangeCount ++;
                }
            }
        }
        [array exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    NSLog(@"选择排序1--最外层循环次数 = %lu",count);
    NSLog(@"选择排序1--交换次数%lu",exchangeCount);
    return array;
}


-(NSMutableArray *)selectionSortByExchangeValueWithDataSource:(NSArray *)array isMaxToMin:(BOOL)isMax
{
    NSMutableArray *sortArr = [NSMutableArray arrayWithArray:array];
    NSInteger count = 0;
    NSInteger exchangeCount = 0;
       for (int i = 0; i < sortArr.count - 1; i++) { //趟数
           count ++;
           for (int j = i + 1; j < sortArr.count; j ++) { //比较次数
               NSInteger first = [sortArr[i] intValue];
               NSInteger second = [sortArr[j] intValue];
               if (isMax) {
                   if (first < second)  {
                       id temp = sortArr[i];
                       sortArr[i] = sortArr[j];
                       sortArr[j] = temp;
                       exchangeCount ++;
                   }
               } else {
                   if ([sortArr[i] intValue] > [sortArr[j] intValue]) {
                                  id temp = sortArr[i];
                                  sortArr[i] = sortArr[j];
                                  sortArr[j] = temp;
                       exchangeCount ++;
                              }
               }
           }
       }
    NSLog(@"选择排序2--最外层循环次数 = %lu",count);
    NSLog(@"选择排序2--交换次数%lu",exchangeCount);
       return sortArr;
}
@end
