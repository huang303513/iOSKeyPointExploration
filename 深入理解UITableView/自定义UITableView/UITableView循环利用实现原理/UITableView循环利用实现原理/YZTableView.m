//
//  YZTableView.m
//  UITableView循环利用实现原理
//
//  Created by 黄成都 on 15/8/8.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "YZTableView.h"

@interface YZTableView ()

// 屏幕可见数组
@property (nonatomic, strong) NSMutableArray *visibleCells;

// 缓存池
@property (nonatomic, strong) NSMutableSet *reuserCells;

// 记录每个可见cell的indexPaths的顺序
@property (nonatomic, strong) NSMutableArray *visibleIndexPaths;

@property (nonatomic, assign) NSInteger rows;

@end


@implementation YZTableView

@dynamic delegate;

- (NSMutableArray *)visibleIndexPaths
{
    if (_visibleIndexPaths == nil) {
        _visibleIndexPaths = [NSMutableArray array];
    }
    
    return _visibleIndexPaths;
}

- (NSMutableSet *)reuserCells
{
    if (_reuserCells == nil) {
        
        _reuserCells = [NSMutableSet set];
        
    }
    return _reuserCells;
}

- (NSMutableArray *)visibleCells
{
    if (_visibleCells == nil) {
        _visibleCells = [NSMutableArray array];
    }
    return _visibleCells;
}

// 刷新tableView
- (void)reloadData
{

    // 刷新方法经常要调用
    // 每次刷新的时候，先把之前记录的全部清空
    // 清空indexPath字典
    [self.visibleIndexPaths removeAllObjects];
    // 清空屏幕可见数组
    [self.visibleCells removeAllObjects];
    
    // 这里不考虑多组，假设tableView默认只有一组。
    
    // 先获取总共有多少cell
    NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:0];
    
    _rows = rows;
    
    
    // 遍历所有cell的高度，计算每行cell的frame
    CGRect cellF;
    CGFloat cellX = 0;
    CGFloat cellY = 0;
    CGFloat cellW = self.bounds.size.width;
    CGFloat cellH = 0;
    
    CGFloat totalH = 0;
    
    for (int i = 0; i < rows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        // 注意：这里获取的delegate，是UIScrollView中声明的属性
        if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            cellH = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
        }else{
            cellH = 44;
        }
        
        cellY = i * cellH;
        
        cellF = CGRectMake(cellX, cellY, cellW, cellH);
        
        
        // 判断有多少cell显示在屏幕上,只加载显示在屏幕上的cell
        if ([self isInScreen:cellF]) { // 当前cell的frame在屏幕上
            // 通过数据源获取cell
            UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
            
            cell.frame = cellF;
            
            // 插入到最里面，否则会挡住分割线
            [self insertSubview:cell atIndex:0];
            
            // 添加到cell可见数组中
            [self.visibleCells addObject:cell];
            
            // 记录每个可见cell的indexPaths的顺序
            [self.visibleIndexPaths addObject:indexPath];


        }
        
        // 添加分割线
        UIView *divideV = [[UIView alloc] initWithFrame:CGRectMake(0, cellY + cellH - 1, cellW, 1)];
        divideV.backgroundColor = [UIColor lightGrayColor];
        divideV.alpha = 0.3;
        [self addSubview:divideV];
        
        // 计算tableView内容总高度
        totalH = cellY + cellH;
        
    }
    
    // 设置tableView的滚动范围
    self.contentSize = CGSizeMake(self.bounds.size.width, totalH);
    
}

// 即将显示的时候刷新表格
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 刷新 表格
    [self reloadData];
}

// 根据cell尺寸判断cell在不在屏幕上
- (BOOL)isInScreen:(CGRect)cellF
{
    // tableView能滚动，因此需要加上偏移量判断
    
    // 当tableView内容往下走，offsetY会一直增加 ,cell的最大y值 < offsetY偏移量   ,cell移除屏幕
    // tableView内容往上走 , offsetY会一直减少，屏幕的最大Y值 <  cell的y值 ，Cell移除屏幕
    // 屏幕最大y值 = 屏幕的高度 + offsetY
    
    // 这里拿屏幕来比较，其实是因为tableView的尺寸我默认等于屏幕的高度，正常应该是tableView的高度。
    // cell在屏幕上， cell的最大y值 > offsetY && cell的y值 < 屏幕的最大Y值(屏幕的高度 + offsetY)
    
    CGFloat offsetY = self.contentOffset.y;
    
    return CGRectGetMaxY(cellF) > offsetY && cellF.origin.y < (self.bounds.size.height + offsetY);

}

// 布局子控件，只要scrollView一滚动就会调用
// 判断有没有新的cell出现，和之前显示在屏幕上的cell有没有从屏幕移除
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 获取当前偏移量
    CGFloat offsetY = self.contentOffset.y;
    
    
    // 获取可见数组中第一个cell
    UITableViewCell *firstCell = nil;
    if (self.visibleCells.count) {
        firstCell = self.visibleCells[0];
    }
    
    // 获取第一个cell的y值
    CGFloat firstCellY = firstCell.frame.origin.y;
    
    // 获取可见数组中最后一个cell
    UITableViewCell *lastCell = [self.visibleCells lastObject];
    
    
    // 获取最后一个cell的y值
    CGFloat lastCellY = lastCell.frame.origin.y;
    
    CGFloat cellH = 0;
    CGFloat cellW = firstCell.frame.size.width;
    CGFloat cellX = firstCell.frame.origin.x;
    CGFloat cellY = 0;
    
    // 判断滚动方向
    if (firstCellY < offsetY) { // 内容往下移动
        
        // 判断有没有滚动到最底部，这个判断有可能不会很准确，因为有可能用户一下拉到最底部，就会导致有些cell还没加载
        // 如果可见的最后一个cell的角标为最后一行，表示加载到最底部，就不需要加载
        NSIndexPath *visibleLastIndexPath = [self.visibleIndexPaths lastObject];
        if (visibleLastIndexPath.row == _rows - 1) {
            
            return;
        }

//        // 判断有没有滚动到最底部
//        if (offsetY + self.bounds.size.height > self.contentSize.height) {
//            return;
//        }
        
        // 判断下当前可见cell数组中第一个cell有没有离开屏幕
        if ([self isInScreen:firstCell.frame] == NO) { // 如果不在屏幕
            // 从可见cell数组移除
            [self.visibleCells removeObject:firstCell];
            
            
            // 删除第0个从可见的indexPath
            if (self.visibleIndexPaths.count) {
                
                [self.visibleIndexPaths removeObjectAtIndex:0];
            }
            
            // 添加到缓存池中
            if (firstCell) {
                
                [self.reuserCells addObject:firstCell];
            }
            
            NSLog(@"%@",self.visibleIndexPaths);
            
            // 移除父控件
            [firstCell removeFromSuperview];
            
        }
        
        // 判断下当前可见cell数组中最后一个cell的下一个cell显没显示在屏幕上
        // 这里需要计算下一个cell的y值，需要获取对应的cell的高度
        // 而高度需要根据indexPath，从数据源获取
        // 可以数组记录每个可见cell的indexPath的顺序,然后获取对应可见的indexPath的角标，就能获取下一个indexPath.
        
        
        // 获取最后一个cell的indexPath
        NSIndexPath *indexPath = [self.visibleIndexPaths lastObject];

        // 获取下一个cell的indexPath
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        
        // 获取cell的高度
        if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            cellH = [self.delegate tableView:self heightForRowAtIndexPath:nextIndexPath];
        }else{
            cellH = 44;
        }

        // 计算下一个cell的y值
        cellY = lastCellY + cellH;
        
        // 计算下下一个cell的frame
        CGRect nextCellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        
        if ([self isInScreen:nextCellFrame]) { // 如果在屏幕上，就加载
            
            // 通过数据源获取cell
            UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:nextIndexPath];
            
            cell.frame = nextCellFrame;
            
            [self insertSubview:cell atIndex:0];
            
            // 添加到cell可见数组中
            [self.visibleCells addObject:cell];
            
            // 添加到可见的indexPaths数组
            [self.visibleIndexPaths addObject:nextIndexPath];
            
            

        }
        
        
    }else{ // 内容往上移动
        
        
        // 判断有没有滚动到最顶部，这个判断有可能不会很准确，因为有可能用户一下拉到最顶部，就会导致有些cell还没加载
        // 可见的第一个cell的角标为0，表示加载到最顶部，就不需要加载
        NSIndexPath *visibleFirstIndexPath = nil;
        if (self.visibleIndexPaths.count) {
           visibleFirstIndexPath   = self.visibleIndexPaths[0];
        }
       
        if (visibleFirstIndexPath.row == 0) {
            
            return;
        }
        
//        // 判断有没有滚动到最顶部
//        if (offsetY < 0) {
//            return;
//        }
        
        
        // 判断下当前可见cell数组中最后一个cell有没有离开屏幕
        if ([self isInScreen:lastCell.frame] == NO ) { // 如果不在屏幕
            // 从可见cell数组移除
            [self.visibleCells removeObject:lastCell];
            
            // 删除最后一个可见的indexPath
            [self.visibleIndexPaths removeLastObject];
            
            // 添加到缓存池中
            [self.reuserCells addObject:lastCell];
            
            // 移除父控件
            [lastCell removeFromSuperview];
            
        }
        
        // 判断下可见cell数组中第一个cell的上一个cell显没显示在屏幕上
        // 获取第一个cell的indexPath
        NSIndexPath *indexPath = nil;
        if (self.visibleIndexPaths.count) {
          indexPath   = self.visibleIndexPaths[0];
        }
        
        

        // 获取下一个cell的indexPath
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0];
        
        // 获取cell的高度
        if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            cellH = [self.delegate tableView:self heightForRowAtIndexPath:preIndexPath];
        }else{
            cellH = 44;
        }
        
        // 计算上一个cell的y值
        cellY = firstCellY - cellH;
        
        
        // 计算上一个cell的frame
        CGRect preCellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        
        if ([self isInScreen:preCellFrame]) { // 如果在屏幕上，就加载

            // 通过数据源获取cell
            UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:preIndexPath];
            
            cell.frame = preCellFrame;
            
            [self insertSubview:cell atIndex:0];
            
            // 添加到cell可见数组中,这里应该用插入，因为这是最上面一个cell,应该插入到数组第0个
            [self.visibleCells insertObject:cell atIndex:0];
            
            // 添加到可见的indexPaths数组,这里应该用插入，因为这是最上面一个cell,应该插入到数组第0个
            [self.visibleIndexPaths insertObject:preIndexPath atIndex:0];
            
        }
        
        
    }
    
}


// 从缓存池中获取cell
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [self.reuserCells anyObject];
    
    // 能取出cell,并且cell的标示符正确
    if (cell && [cell.reuseIdentifier isEqualToString:identifier]) {
        // 从缓存池中获取
        [self.reuserCells removeObject:cell];
        
        return cell;
    }
    
    return nil;
}


@end
