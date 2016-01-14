//
//  ViewController.m
//  对KeyChain实现数据的增删查改
//
//  Created by huangchengdu on 16/1/14.
//  Copyright © 2016年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import "HAIKeyChainManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *key;

@property (weak, nonatomic) IBOutlet UITextField *value;
@end

@implementation ViewController

- (IBAction)add:(id)sender {
    [self.value endEditing:YES];
    [[HAIKeyChainManager sharedHAIKeyChainManager] addKeyChainWithKey:self.key.text value:self.value.text];
}


- (IBAction)delete:(id)sender {
    [self.value endEditing:YES];
    [[HAIKeyChainManager sharedHAIKeyChainManager] deleteKeyChainWithKey:self.key.text];
}


- (IBAction)search:(id)sender {
    [self.value endEditing:YES];
    [[HAIKeyChainManager sharedHAIKeyChainManager] getKeyChainValueWithKey:self.key.text];
}

- (IBAction)change:(id)sender {
    [self.value endEditing:YES];
    [[HAIKeyChainManager sharedHAIKeyChainManager] updateKeyChainWithKey:self.key.text value:self.value.text];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
