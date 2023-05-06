//
//  XWSDKHeader.h
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#ifndef XWSDKHeader_h
#define XWSDKHeader_h

#define WS(weakSelf)   __weak __typeof(&*self) weakSelf = self;


#define kFont(x)                      [UIFont systemFontOfSize:x]
#define kTextFont kFont(14)
#define kSectionFont kFont(13)


#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]


#define kLineViewColor                UIColorHex(0xC1C1C2)

#define kTableLineViewColor           UIColorHex(0xC8C7CC)
#define kTableViewBGColor             UIColorHex(0xEEEEF4)

#define kTextColor                    UIColorHex(0x000000)
#define kTextDetailColor              UIColorHex(0x8E8E93)

#define kButtonTitleColorNormal       UIColorHex(0xFFFFFF)
#define kButtonTitleColorHighlighted  UIColorHex(0XE5E5E5)

#define kLogOutRedColorNormal         UIColorHex(0xFF4330)
#define kLogOutRedColorHighlighted    UIColorHex(0xD64334)

#define kMainColor                    UIColorHex(0x77ADEE)


//
#define XWColorValue                  0x77ADEE
#define XWAdapterBtnNomal             UIColorHex(0x77ADEE)

#define XWAdapterHead                 UIColorHexAlpha(XWColorValue, 0.7)
#define XWAdapterBorde                UIColorHexAlpha(XWColorValue, 0.5)

#define XWAdapterBtnHigh              UIColorHex(0x77ADEE)
#define XWAdapterFont                 UIColorHexAlpha(0x77ADEE, 0.9)

#define XWAdapterViewBg               UIColorHex(0xf3d2b3)



#define kImage(image) [UIImage imageNamed:image]

#define UIColorHexAlpha(hexValue, a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f green:((float)((hexValue & 0xFF00) >> 8))/255.0f blue:((float)(hexValue & 0xFF))/255.0f alpha:a]



#endif /* XWSDKHeader_h */
