//
//  ZZUITextViewDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITextViewDelegate.h"

@implementation ZZUITextViewDelegate
@synthesize protocolMethods = _protocolMethods;
@synthesize textViewShouldBeginEditing = _textViewShouldBeginEditing;
@synthesize textViewDidBeginEditing = _textViewDidBeginEditing;
@synthesize textViewShouldEndEditing = _textViewShouldEndEditing;
@synthesize textViewDidEndEditing = _textViewDidEndEditing;
@synthesize textView_shouldChangeCharactersInRange_replacementText = _textView_shouldChangeCharactersInRange_replacementText;
@synthesize textViewDidChange = _textViewDidChange;
@synthesize textViewDidChangeSelection = _textViewDidChangeSelection;


- (NSArray *)protocolMethods
{
    if (!_protocolMethods) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:self.textViewShouldBeginEditing];
        [array addObject:self.textViewDidBeginEditing];
        [array addObject:self.textViewShouldEndEditing];
        [array addObject:self.textViewDidEndEditing];
        [array addObject:self.textView_shouldChangeCharactersInRange_replacementText];
        [array addObject:self.textViewDidChange];
        [array addObject:self.textViewDidChangeSelection];
        NSArray *superProtocolMethods = [super protocolMethods];
        for (ZZMethod *method in superProtocolMethods) {
            [method setSelected:NO];
        }
        [array addObjectsFromArray:superProtocolMethods];
        _protocolMethods = array;
    }
    return _protocolMethods;
}

- (ZZMethod *)textViewShouldBeginEditing
{
    if (!_textViewShouldBeginEditing) {
        _textViewShouldBeginEditing = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textViewShouldBeginEditing:(UITextView *)textView" selected:NO];
    }
    return _textViewShouldBeginEditing;
}

- (ZZMethod *)textViewDidBeginEditing
{
    if (!_textViewDidBeginEditing) {
        _textViewDidBeginEditing = [[ZZMethod alloc] initWithMethodName:@"- (void)textViewDidBeginEditing:(UITextView *)textView" selected:NO];
    }
    return _textViewDidBeginEditing;
}

- (ZZMethod *)textViewShouldEndEditing
{
    if (!_textViewShouldEndEditing) {
        _textViewShouldEndEditing = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textViewShouldEndEditing:(UITextView *)textView" selected:NO];
    }
    return _textViewShouldEndEditing;
}

- (ZZMethod *)textViewDidEndEditing
{
    if (!_textViewDidEndEditing) {
        _textViewDidEndEditing = [[ZZMethod alloc] initWithMethodName:@"- (void)textViewDidEndEditing:(UITextView *)textView" selected:NO];
    }
    return _textViewDidEndEditing;
}

- (ZZMethod *)textView_shouldChangeCharactersInRange_replacementText
{
    if (!_textView_shouldChangeCharactersInRange_replacementText) {
        _textView_shouldChangeCharactersInRange_replacementText = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textView:(UITextView *)textView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string" selected:NO];
    }
    return _textView_shouldChangeCharactersInRange_replacementText;
}

- (ZZMethod *)textViewDidChange
{
    if (!_textViewDidChange) {
        _textViewDidChange = [[ZZMethod alloc] initWithMethodName:@"- (void)textViewDidChange:(UITextView *)textView" selected:NO];
    }
    return _textViewDidChange;
}

- (ZZMethod *)textViewDidChangeSelection
{
    if (!_textViewDidChangeSelection) {
        _textViewDidChangeSelection = [[ZZMethod alloc] initWithMethodName:@"- (void)textViewDidChangeSelection:(UITextView *)textView" selected:NO];
    }
    return _textViewDidChangeSelection;
}

@end
