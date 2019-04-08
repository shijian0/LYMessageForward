//
//  Person.m
//  LYMessageForward
//
//  Created by LiYong on 2019/4/8.
//  Copyright © 2019 勇 李. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Dog.h"
#import "Cat.h"
static NSArray * respondClasses;

@interface Person ()
@end

@implementation Person

//1
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"1:%s%@",__func__,NSStringFromSelector(sel));
    //1 动态添加eat：方法 输出：person eat 鸡腿
//    if (sel == @selector(eat:)) {
//        BOOL success = class_addMethod([self class], sel, (IMP)(eat), "v@:");
//        if (success) {
//            return success;
//        }
//    }ea
    return [super resolveInstanceMethod:sel];
}
//2
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"2:%s%@",__func__,NSStringFromSelector(aSelector));
    id forwardTarget = [super forwardingTargetForSelector:aSelector];
    
    if (forwardTarget) {
        return forwardTarget;
    }
//    Class someClass = [self lyResponsdClassForSelector:aSelector];
    //1 将消息转发给dog 执行，输出 dog eat 鸡腿
//    Class someClass = [Dog class];
//    if (someClass) {
//        forwardTarget = [someClass new];
//    }
    return forwardTarget;
}
//3
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"4:%s%@",__func__,NSStringFromSelector(anInvocation.selector));
    Cat * cat = [Cat new];
    if ([cat respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:cat];
    }else{
        NSLog(@"not response selector :%@",NSStringFromSelector(anInvocation.selector));
    }
    
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"3:%s%@",__func__,NSStringFromSelector(aSelector));
    NSMethodSignature * methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        //1 将消息转发给cat 执行，输出 cat eat 鸡腿

        //手动创建和自动创建
        //1 手动创建
//        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        //2 自动创建
        Cat * cat = [Cat new];
        methodSignature = [cat methodSignatureForSelector:aSelector];
    }
    return methodSignature;
}
- (Class)lyResponsdClassForSelector:(SEL)selector{
    respondClasses = @[[NSMutableArray class],[NSMutableDictionary class],[NSMutableString class],[NSNumber class],[NSDate class],[NSData class]];
    for (Class someClass in respondClasses) {
        if ([someClass instanceMethodForSelector:selector]) {
            return someClass;
        }
    }
    return nil;
}
void eat(id self,SEL _cmd,id objc){
    NSLog(@"person eat %@",objc);
}
@end
