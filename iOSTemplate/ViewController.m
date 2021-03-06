//
//  ViewController.m
//  iOSTemplate
//
//  Created by ARIST on 2017/8/23.
//  Copyright © 2017年 Neil. All rights reserved.
//

#import "ViewController.h"


#import "CardView.h"
#import "CardData.h"
#import "CardItem.h"
#import "CardItem2.h"
#import "CardViewConstants.h"

@interface ViewController ()<CardViewDelegate, CardViewDataSource>
{
    BOOL __oneTypeItem;
    CardViewItemScrollMode __cardViewMode;
}
@property (strong, nonatomic) NSMutableArray<CardData *> * model1;
@property (strong, nonatomic) NSMutableArray<NSString *> * model2;

@end



static NSString * ITEM_XIB    = @"CardItem";
static NSString * ITEM_XIB_2  = @"CardItem2";
static NSString * ITEM_RUID   = @"Item_RUID";
static NSString * ITEM_RUID_2 = @"Item_RUID2";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    [self initData];
    
    self.cardView.delegate   = self;
    self.cardView.dataSource = self;
    self.cardView.maxItems   = 3;
    self.cardView.scaleRatio = 0.05;
    
    self.cardViewHeightConstraint.constant = CARD_ITEM_H + 100;
    // 修改约束后 cardView 的高度不会立即生效，依然是以 530 来计算，会导致 item 项布局错误，所以此处调用
    [self.view layoutIfNeeded];
    
    [self.cardView registerXibFile:ITEM_XIB forItemReuseIdentifier:ITEM_RUID];
    [self.cardView registerXibFile:ITEM_XIB_2 forItemReuseIdentifier:ITEM_RUID_2];
    [self.cardView reloadData];

}

- (void)initData
{
    __oneTypeItem  = YES;
    __cardViewMode = CardViewItemScrollModeDelete;
    
    NSArray * imageNames = @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    NSArray * titles = @[ @"饮食方案一", @"饮食方案二", @"饮食方案三", @"运动方案四", @"运动方案五",
                          @"体检方案六", @"饮食方案七", @"饮食方案八", @"饮食方案九" ];
    
    self.model1 = [NSMutableArray array];
    
    for (NSInteger i = 0; i < imageNames.count; i++) {
        
        [self.model1 addObject:[[CardData alloc] initWithImageName:imageNames[i]
                                                             title:titles[i]]];
    }
    
    self.model2 = [NSMutableArray arrayWithObjects: @"火1", @"火2", @"火3", @"火4", @"火5", @"火6", @"火7", @"火8", @"火9", nil];
}

#pragma mark - CYKJCardViewDelegate/DataSource

- (NSInteger)numberOfItemsInCardView:(CardView *)cardView
{
    if (!__oneTypeItem) {
        
        return [self.model1 count] + [self.model2 count];
    }
    return [self.model1 count];
}

- (CardViewItem *)cardView:(CardView *)cardView itemAtIndex:(NSInteger)index
{
    if (!__oneTypeItem && index % 2) {
        
        CardItem2 * item2 = (CardItem2 *)[cardView dequeueReusableCellWithIdentifier:ITEM_RUID_2];
        
        item2.imageView.image = [UIImage imageNamed:self.model2[index/2]];
        
        return item2;
    }
    
    CardItem * item = (CardItem *)[cardView dequeueReusableCellWithIdentifier:ITEM_RUID];
    
    NSInteger idx = __oneTypeItem ? index : index / 2;
    
    [item setItemWithData:self.model1[idx]];
    
    return item;
}

- (CGRect)cardView:(CardView *)cardView rectForItemAtIndex:(NSInteger)index
{
    return CGRectMake(0, 0, CARD_ITEM_W, CARD_ITEM_H);
}

- (void)cardView:(CardView *)cardView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"卡片%ld被选中", (long)index);
}

- (void)timeAction{
    
    NSLog(@"timeAction");
    
//    [[HttpClient shareInstance] cancelTask:self.task];
    
}


- (IBAction)sendAction:(id)sender {
    
    self.task = [[HttpClient shareInstance] getWithURL:@"http://dev.yogapay.com:6760/api/main/index" completeBlock:^(NSDictionary *result) {
        
        NSLog(@"\nViewController:\n%@", result);
        
    }];
    
//    [self.task cancel];
    
}

- (IBAction)cancelAction:(id)sender {
    
    if (self.task) {
        [self.task cancel];
    }
}

@end
