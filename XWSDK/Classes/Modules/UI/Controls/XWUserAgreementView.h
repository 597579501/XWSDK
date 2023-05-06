#import "XWView.H"

typedef void (^checkClickBlock)(BOOL isCheck);
typedef void (^labelClickBlock)(void);

@interface XWUserAgreementView : XWView
{
    
    
    
}

@property (nonatomic, assign) BOOL            isCheck;
@property (nonatomic, copy) checkClickBlock checkClickBlock;
@property (nonatomic, copy) labelClickBlock labelClickBlock;
- (void)setCheckClickBlock:(checkClickBlock)checkClickBlock;
- (void)setLabelClickBlock:(labelClickBlock)labelClickBlock;

@end
