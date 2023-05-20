#import "XWView.H"

typedef void (^checkClickBlock)(BOOL isCheck);
typedef void (^labelClickBlock)(void);
typedef void (^PrivacyLabelClickBlock)(void);

@interface XWUserAgreementView : XWView
{
    
    
    
}

@property (nonatomic, assign) BOOL            isCheck;
@property (nonatomic, copy) checkClickBlock checkClickBlock;
@property (nonatomic, copy) labelClickBlock labelClickBlock;
@property (nonatomic, copy) PrivacyLabelClickBlock privacyLabelClickBlock;


//- (void)setCheckClickBlock:(checkClickBlock)checkClickBlock;
//- (void)setLabelClickBlock:(labelClickBlock)labelClickBlock;

@end
