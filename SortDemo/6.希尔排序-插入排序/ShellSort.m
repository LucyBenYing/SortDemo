//
//  ShellSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "ShellSort.h"

@implementation ShellSort
+(void)test
{
    [[ShellSort new] test1];
}

 
-(void)test1
{
    NSMutableArray *arr =[NSMutableArray arrayWithArray: @[@(13),@(222),@(28),@(333)]];
    [self shellSort:arr isFromMAxToMin:NO];
    
}

/**
 希尔排序-插入排序
    基本思想：
        1.希尔排序相当于直接插入排序的加强版，在直接插入排序的概念上加入了增量这个概念。
    什么是增量呢？
    1.插入排序只能与相邻的元素进行比较，而希尔排序则是进行跳跃比较，而增量就是跳跃的间隔数。
    所谓增量即是把数组按照一定间隔数分组成不同的数组。
        例如：@{1,2,3,4,5,6}一共有6个元素，假设吧数组按照增量3进行分组，那么就是@{1,4},@{2,5},@{3,6}各分为一组。
        因为增量是3，所以每隔3个下坐标为一组，直到取到数组末尾，如果数组还有第7个元素7，那么按照增量分组的第一组h数据是@{1，4，7}.
    按照增量分组后，把每一组的元素按照插入排序进行排序。
    当按照一个增量分组完成并每组数据按照插入排序完成后，将增量设为原本的二分之一，然后重复上面的步骤进行插入排序。
    直到增量为1，按照增量为1的最后一次进行分组插入排序，即完成了排序。
 
 */
/**
 希尔排序
   @param array 需要排序的数组
   @param isFromMaxToMin Yes 表示从大到小排序 NO 表示从小到大
*/
-(void)shellSort:(NSMutableArray *)array isFromMAxToMin:(BOOL)isFromMaxToMin
{
//    l 是增量大小 标记当前数组是按照l长度间隔分段数据的
    NSInteger l = array.count / 2;
// 标记按照l增量大小分段数组，indexCount表示数组被分为几组
    NSInteger indexCount = array.count % 2 > 0 ? array.count/2 + 1 : array.count /2;
    
    while (l >= 1) {
//         根据indexCount ， 对每组包含的元素进行比较
        for (int i = 0; i < indexCount; i ++){
//             进行直接插入排序，默认比较数组第一个元素为已排序，所以从i+l开始，i表示当前数组第一个元素，i+ l表示当前h数组第二个元素
            for(NSInteger j = i + l; j < array.count    ;j += l){
//标记当前比较元素的下坐标
                NSInteger index_j = j;
//                用当前j元素与前面已排序的所有元素进行比较，不能越界所以数组的下坐标大于0
                if(j - l >= 0){
//                    temp_i 是记录当前未排序元素的前一个元素（即已排序元素中最末一个元素）
                    NSInteger temp_i = [[array objectAtIndex:j - l] integerValue];
//                    temp_j是记录当前需要比较的未排序元素
                    NSInteger temp_j = [[array objectAtIndex:j] integerValue];
//                    当已排序数组最末尾元素大于未排序元素时，需要要用未排序元素与已排序元素的y下一个元素进行比较
//                    如果已排序数组最末元素小于未排序元素时，则直接进入下一个未排序元素的比较
                    if(temp_i > temp_j){
//                        交换位置
                        [array exchangeObjectAtIndex:j withObjectAtIndex:j - l];
                        index_j = j - l;
                        NSInteger x = j - l - l;
//                        数组下坐标不能越界，所以 x > 0
                        while (x >= 0) {
//                            temp_x 记录的下一个需要比较的已排序元素
                            NSInteger temp_x = [[array objectAtIndex:x] integerValue];
//                            只要发生已排序元素大于未排序元素就进行交换
                            if (temp_x > temp_j) {
                                [array exchangeObjectAtIndex:x withObjectAtIndex:index_j];
//                                重新记录未排序元素在数组的下坐标
                                index_j = x;
//                                让x进行下一个元素的比较
                                x -= l;
                            } else {
//                                如果发现已排序元素小于未排序元素，则说明未排序元素已经找到在已排序数组中的位置
//                               则使 x = -1 跳出while循环
                                x = -1;
                            }
                        }
                    }
                }
            }
        }
// 重新计算下一次的数组
        indexCount = l %2 > 0 ? l/2 + 1 : l/2;
        l = l/2;
    }
    
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    NSLog(@"希尔排序结果为：%@",array);
}

@end
