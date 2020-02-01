//
//  InsertSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "InsertSort.h"

@implementation InsertSort

+(void)test
{
    [[InsertSort new] test1];
}

 
-(void)test1
{
    NSMutableArray *arr =[NSMutableArray arrayWithArray: @[@(13),@(222),@(28),@(333)]];
    [self insertSort: arr isFromMaxToMin:NO];
    
}


/**
 插入排序 直接插入排序
 基本思路：
    1.每轮排序把数组分为2部分，一部分为已排序好的数组，一部分为还未排序好的数组。
    2.每次取出还未排序好的数组中首元素与已排序好的数组从右往左比较。
    3.如果发现从未排序中取出的元素比从已排序中取出的元素大，就把该未排序的元素插入到已排序中取出元素的后面。
    4.这样每一轮就能确定一个未排序元素在已排序数组中的准确位置。
 */
/**
 对数组进行直接插入排序
@param array 需要进行排序的数组
@param isFromMaxToMin 数组排序的方式，yes 从大到小排序，no 从小到大
*/
-(void)insertSort:(NSMutableArray  *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
//    i 从1 开始，因为第一次插入排序操作时，假设的是数组第一个元素所组成的是一个有序数组。
//    所以需要用后面无序数组的元素与第一个元素进行插入比较
    for (int i = 1; i <= array.count - 1; i ++) {
//        temp_i 是当前未排序数组的首个元素，需要用该元素与已排序数组中的所有元素比较
        NSInteger temp_i = [[array objectAtIndex:i] intValue];
//        j 是已排序数组的最末尾（即最右边，从右往左比较）的元素下坐标
        NSInteger j = i - 1;
//        j必须大于0 否则数组越界，当j = 0的时候说明Temp_i已经与已排序数组中所有元素进行比较
        while (j >= 0) {
//            从已排序数组中取出的元素
            NSInteger temp_j = [[array objectAtIndex:j ] intValue];
//            当已排序数组中元素比未排序数组元素小时，说明需要把未排序元素插入到该已排序元素的后面
            if(temp_i > temp_j){
//                当j = i- 1 时，说明已排序最末尾元素与未排序最前面元素排序时正常的。
//                这种情况下不需要交换位置，直接退出while循环
                if(j == (i - 1)){
                    j = -1;
                } else {
//                    进行插入操作。先把元素从数组中移除，再把元素插入到已排序元素的后面位置
                    [array removeObjectAtIndex:i];
                    [array insertObject:[NSString stringWithFormat:@"%zd",temp_i] atIndex:j + 1];
//                    跳出当前循环
                    j = -1;
                }
            } else {
//                当已排序数组中元素比未排序数组元素大时则忽略本次，让该未排序元素与下一个已排序元素进行比较。
//                直到j == 0 或发现比未排序元素小的元素
//                当j == 0 时，说明该未排序元素与已排序数组所有元素都进行比较了，且该未排序元素小于所有已排序元素，
//                那么就应该把该元素插入到已排序数组的最前面。
                if(j == 0) {
//                    进行插入操作，先把元素从数组中移除，再把元素插入到已排序元素的后面位置
                    [array removeObjectAtIndex:i];
                    [array insertObject:[NSString stringWithFormat:@"%zd",temp_i] atIndex:0];
                }
                j--;
            }
        }
    }
    
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    NSLog(@"直接插入排序的结果为：%@",array);
}


@end
