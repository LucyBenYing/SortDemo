//
//  SortTest.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/2/1.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "SortTest.h"
#import "BubbleSort.h"
#import "SelectSort.h"
#import "HeapSort.h"
#import "InsertSort.h"
#import "ShellSort.h"
#import "QuickSort.h"
#import "MergeSort.h"
#import "RadixSort.h"

@implementation SortTest
+(void)test
{
    //测试冒泡排序
        [BubbleSort test];
    //测试选择排序
        [SelectSort test];
    //    测试堆排序
        [HeapSort test];
    //    插入排序
        [InsertSort test];
    //    快速排序
        [QuickSort test];
    //    希尔排序
        [ShellSort test];
    ////    归并排序
        [MergeSort test];
    ////    基数排序
        [RadixSort test];
}
@end
