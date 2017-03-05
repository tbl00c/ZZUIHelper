//
//  ZZUITextFieldDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITextFieldDelegate.h"

@implementation ZZUITextFieldDelegate
@synthesize protocolMethods = _protocolMethods;
@synthesize textFieldShouldBeginEditing = _textFieldShouldBeginEditing;
@synthesize textFieldDidBeginEditing = _textFieldDidBeginEditing;
@synthesize textFieldShouldEndEditing = _textFieldShouldEndEditing;
@synthesize textFieldDidEndEditing = _textFieldDidEndEditing;
@synthesize textField_shouldChangeCharactersInRange_replacementString = _textField_shouldChangeCharactersInRange_replacementString;
@synthesize textFieldShouldClear = _textFieldShouldClear;
@synthesize textFieldShouldReturn = _textFieldShouldReturn;


- (NSArray *)protocolMethods
{
    if (!_protocolMethods) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:self.textFieldShouldBeginEditing];
        [array addObject:self.textFieldDidBeginEditing];
        [array addObject:self.textFieldShouldEndEditing];
        [array addObject:self.textFieldDidEndEditing];
        [array addObject:self.textField_shouldChangeCharactersInRange_replacementString];
        [array addObject:self.textFieldShouldClear];
        [array addObject:self.textFieldShouldReturn];
        NSArray *superProtocolMethods = [super protocolMethods];
        for (ZZMethod *method in superProtocolMethods) {
            [method setSelected:NO];
        }
        [array addObjectsFromArray:superProtocolMethods];
        _protocolMethods = array;
    }
    return _protocolMethods;
}

- (ZZMethod *)textFieldShouldBeginEditing
{
    if (!_textFieldShouldBeginEditing) {
        _textFieldShouldBeginEditing = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField" selected:NO];
    }
    return _textFieldShouldBeginEditing;
}

- (ZZMethod *)textFieldDidBeginEditing
{
    if (!_textFieldDidBeginEditing) {
        _textFieldDidBeginEditing = [[ZZMethod alloc] initWithMethodName:@"- (void)textFieldDidBeginEditing:(UITextField *)textField" selected:NO];
    }
    return _textFieldDidBeginEditing;
}

- (ZZMethod *)textFieldShouldEndEditing
{
    if (!_textFieldShouldEndEditing) {
        _textFieldShouldEndEditing = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textFieldShouldEndEditing:(UITextField *)textField" selected:NO];
    }
    return _textFieldShouldEndEditing;
}

- (ZZMethod *)textFieldDidEndEditing
{
    if (!_textFieldDidEndEditing) {
        _textFieldDidEndEditing = [[ZZMethod alloc] initWithMethodName:@"- (void)textFieldDidEndEditing:(UITextField *)textField" selected:NO];
    }
    return _textFieldDidEndEditing;
}

- (ZZMethod *)textField_shouldChangeCharactersInRange_replacementString
{
    if (!_textField_shouldChangeCharactersInRange_replacementString) {
        _textField_shouldChangeCharactersInRange_replacementString = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string" selected:NO];
    }
    return _textField_shouldChangeCharactersInRange_replacementString;
}

- (ZZMethod *)textFieldShouldClear
{
    if (!_textFieldShouldClear) {
        _textFieldShouldClear = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textFieldShouldClear:(UITextField *)textField" selected:NO];
    }
    return _textFieldShouldClear;
}

- (ZZMethod *)textFieldShouldReturn
{
    if (!_textFieldShouldReturn) {
        _textFieldShouldReturn = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)textFieldShouldReturn:(UITextField *)textField" selected:NO];
    }
    return _textFieldShouldReturn;
}

@end
