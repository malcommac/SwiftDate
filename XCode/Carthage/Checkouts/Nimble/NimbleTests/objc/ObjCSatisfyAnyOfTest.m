#import <XCTest/XCTest.h>
#import "NimbleSpecHelper.h"

@interface ObjCSatisfyAnyOfTest : XCTestCase

@end

@implementation ObjCSatisfyAnyOfTest

- (void)testPositiveMatches {
    expect(@2).to(satisfyAnyOf(equal(@2), equal(@3)));
    expect(@2).toNot(satisfyAnyOf(equal(@3), equal(@16)));
    expect(@[@1, @2, @3]).to(satisfyAnyOf(equal(@[@1, @2, @3]), allPass(beLessThan(@4))));
    expect(@NO).to(satisfyAnyOf(beTrue(), beFalse()));
    expect(@YES).to(satisfyAnyOf(beTrue(), beFalse()));
}

- (void)testNegativeMatches {
    expectFailureMessage(@"expected to match one of: {equal <3.0000>}, or {equal <4.0000>}, or {equal <5.0000>}, got 2", ^{
        expect(@2).to(satisfyAnyOf(equal(@3), equal(@4), equal(@5)));
    });
    
    expectFailureMessage(@"expected to match one of: {all be less than <4.0000>, but failed first at element"
                         " <5.0000> in <[5.0000, 6.0000, 7.0000]>}, or {equal <(1,2,3,4)>}, got (5,6,7)", ^{
                             expect(@[@5, @6, @7]).to(satisfyAnyOf(allPass(beLessThan(@4)), equal(@[@1, @2, @3, @4])));
                         });
    
    expectFailureMessage(@"satisfyAnyOf must be called with at least one matcher", ^{
        expect(@"turtles").to(satisfyAnyOf());
    });
}
@end
