//
//  EMViewController.m
//  Emojiyus
//
//  Created by Mikhail Kurenkov on 12/23/2017.
//  Copyright (c) 2017 Mikhail Kurenkov. All rights reserved.
//

#import "EMViewController.h"

#import <Emojiyus/Emojiyus.h>

@interface EMViewController () <UITextViewDelegate>

@property (strong, nonatomic) Emojiyus *emojiyus;

@end

@implementation EMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"emoji" withExtension:@"json"];
    self.emojiyus = [[Emojiyus alloc] initWithMappingJsonUrl:url];
}

#pragma mark - <UITextViewDelegate>

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%s - %@", __func__, textView.text);
    NSRange selectedRange = textView.selectedRange;
    textView.text = [self.emojiyus emojify:textView.text selectedRange:&selectedRange];
    textView.selectedRange = selectedRange;
}

@end
