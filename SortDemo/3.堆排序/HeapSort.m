//
//  HeapSort.m
//  SortDemo
//
//  Created by 鲁本英 on 2020/1/31.
//  Copyright © 2020 鲁本英. All rights reserved.
//

#import "HeapSort.h"

@implementation HeapSort

+(void)test
{
    [[HeapSort new] testHeapSort];
}

#pragma mark - 3. 堆排序
-(void)testHeapSort
{
    NSMutableArray *arr =[NSMutableArray arrayWithArray: @[@(13),@(222),@(28),@(333)]];
    [self heapSortWithDataSource:arr isFromMaxToMin:YES ];
}

/**
 3. 堆排序
    基本思想：
    将数组转换为大顶堆和小顶堆二叉树，取出二叉树中的根（即最大最小值）。
    然后对剩余的元素递归重构转换为新的二叉树。
    直到所有元素递归完毕，就能得到正确的排序
                        
 主要步骤：
 1.首先把原数组重构成一个大顶堆或者小顶堆二叉树（下面都按照大顶堆举例说明）
 2.把重构后的二叉树的根节点与数组最末尾的数进行交换，这样当前重构后的二叉树中最大值就到了数组最末尾。
 然后将当前交换后的数组中除最末尾的元素意外的元素进行大顶堆的重构，在进行步骤2的操作进行递归，
 每次都要再上次交换后的数组上减少1的长度，来忽略交换后最末尾的最大值，
 这样每次递归就能找到当前数组中的最大值。一直递归将剩下没有进行重构交换的元素全部重构交换，直到所有元素递归完成。
 */

/**
 将数组按照完全二叉树方式进行重新构造成一个新堆（构造成一个标准的）
 @param array 源数组
 @param parent 当前需要判断的父节点（根据需要判断的父节点，去判断其左右数是否满足对结构，不满足就进行交换）
 @param length 数组的长度
 */
-(void)HeapAdjust:(NSMutableArray *)array parent:(int)parent length:(int )length
{
//    根据父节点parent的位置去计算其左子树在数组中的下坐标
//    因为在二叉树中，必须有左子树才会有又子树。
//    如果没有左子树，说明这个父节点是最下层的子树，这种情况就可以不用再做判断了
    
    /*
    为什么 2 * parent +1 就是左子树的下坐标呢？
     因为二叉树是按照第一排显示1个，第二排显示2个，第三排显示4个以此类推的方式显示的。
     满足一下规律：
     设当前元素在数组中以array[i]表示，那么
     1.它的左孩子节点是：array[2 * i + 1];
     2.它的右孩子节点是：array[2 + i + 2];
     3.它的父节点是： array[(i - 1)/2];
     4.array[i] <= array[2 * i + 1] 且 array[i] <= array[2 * i + 2];
     */
    
    int l_child = 2 * parent +1;//左子树下坐标
    int r_child = l_child + 1;//右子树下坐标
//    判断当前计算出来的右子树下标有没有查过数组的长度，如果没有超过说明该父节点拥有右子树。
//    如果超过且该节点拥有左子树节点则说明该机诶单是最下层的最后一个父节点，
//    如果超过且没有左子树，则说明该节点不是父节点且是数组最后一个元素。
    
//    这里之所以使用while进行判断而不是if，
//    因为判断当前节点后，还要继续向当前节点的子树节点之下进行筛选判断。所以用wile
    NSLog(@"before 堆 = %@ ，parent = %d,length = %d",array,parent,length);
    while (r_child < length){
        int l = [[array objectAtIndex:l_child] intValue];
        int r = [[array objectAtIndex:r_child] intValue];
        int p = [[array objectAtIndex:parent] intValue];
        
//        如果右子树的值大于左子树，则选取右子树的值来与福及诶单进行判断
        if (l < r) {
//            当右子树的值大于父节点时，需要把右子树的值与父节点的进行交换
            if(p > r){
                [array exchangeObjectAtIndex:parent withObjectAtIndex:r_child];
            }
//            重新选取当前已经判断过的父节点的右子树当做父节点，继续向下递归筛选判断
            parent = r_child;
        } else {
//            当左子树值大于右子树时，用左子树t与父节点进行判断
            if(p < l){
//                当左子树值大于父节点时，把左子树的值与父节点进行交换
                [array exchangeObjectAtIndex:parent withObjectAtIndex:l_child];
            }
//            冲洗选取当前已经判断过的父节点的左子树当做父节点，继续向下递归筛选判断
            parent = l_child;
        }
//        重新 选取左右子树下坐标
        l_child = 2 * parent + 1;
        r_child = l_child + 1;
        NSLog(@"after du array = %@",array);
    }
    
//    判断左子树是否存在，并判断左子树是否超过父节点
//    这里不进行递归是因为如果只有左子树，则表明该左子树为数组最后一个数。不需要进行递归了
  
    if(l_child < length ){
        int l = [[array objectAtIndex:l_child] intValue];
          int p = [[array objectAtIndex:parent] intValue];
        if (l > p) {
             [array exchangeObjectAtIndex:parent withObjectAtIndex:l_child];
        }
       
    }
      NSLog(@" 一轮结束 array = %@",array);
}
/**
  对数组进行堆排序
 @param array 需要进行排序的数组
 @param isFromMaxToMin 数组排序的方式，yes 从大到小排序，no 从小到大
 */
-(void)heapSortWithDataSource:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    if(!array)
    {
        return;
    }
    if (array.count < 2) {
        return;
    }
//    firstIndex 表示从哪一个下坐标开始去进行节点排序
//   为什么是array.count/2，因为数组的一半，能保证前一半的数据中所有值都是父节点，都拥有子节点。
//    而后根据父节点去递归子节点
    int firstIndex = (int)(array.count / 2);
    int arrayCount = (int)array.count;
//    1.首先将原数组排序h为一个初始堆
    for(int i = firstIndex ;i >= 0; i --){
        [self HeapAdjust:array parent:i length:arrayCount];
    }
//
    NSLog(@"初始化堆  =%@",array);
    while (arrayCount > 0) {
        [array exchangeObjectAtIndex:arrayCount - 1 withObjectAtIndex:0];
        arrayCount --;
        [self HeapAdjust:array parent:0 length:arrayCount];
    }
    NSLog(@"排序后结果 = %@",array);
//    如果需要从大到小排序，将数组逆序
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
}
@end
