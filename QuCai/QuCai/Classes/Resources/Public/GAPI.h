//
//  GAPI.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/31.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#ifndef GAPI_h
#define GAPI_h

#define kPOST @"POST"
#define kGET @"GET"


#define kFilePath @"https://www.txwl-json.com/tych/"




//图片
#define kMobilePicture @"mobleWebcomConfig.do"

//公告
#define kAnnouncement @"gonggao.do"

//token
#define kGetToken @"User/getToken"

// 注册
#define kRegister @"User/register"

// 登录
#define kLogin @"login.do"

// 检查登录状态
#define kCheckLogin @"checklogin.do"

// 图片验证码
#define kImgValidateCode @"validateCode"

// MG电子
#define kH5MG @"GAMEMG"

// HB电子
#define kH5HB @"GAMEHABA"

//跳转游戏
#define kenterGame @"User/forwardGame"

//转账到游戏
#define kTransGame @"User/TransferTo"

//获取转账信息
#define kGetTransInfo @"User/getTransferInfo"

//获取余额
#define kGetBalance @"User/getBalance"

//转账到平台
#define kTransFrom @"User/TransferFrom"

//获取用户信息
#define kGetUserInfo @"User/getUserInfo"

//获取资金流水记录
#define kQueryByTreasurePage @"User/queryByTreasurePage"

//获取存款记录
#define kGetReChargeInfo @"User/getReChargeInfo"

//获取提款记录
#define kGetWithDrawInfo @"User/getWithDrawInfo"

//获取游戏记录
#define kGetBetInfo @"User/getBetInfo"

//修改登陆密码
#define kChangePassword @"User/changePassword"

//修改取款密码
#define kChangeQkpwd @"User/changeQkpwd"

//获取银行卡列表
#define kGetUserCard @"User/getUserCard"

//检测是否设置取款密码
#define kCheckQkpwd @"User/checkQkpwd"

//添加银行卡
#define kAddUserCard @"User/addUserCard"

//查询用户打码量，游戏金额，强制提款手续费
#define kSelectWithdrawConfig @"User/selectWithdrawConfig"

//申请提款
#define kWithDraw @"User/WithDraw"

//获取二维码
#define kGetQRCode @"alipayPaymentScanCode/getQRCode"

//二维码订单支付
#define kGetOrder @"alipayPaymentScanCode/getOrder"

//获取平台支付
#define kGetPlatformPay @"PlatformPay/getPaymentList"

//银行卡列表
#define kGetBankList @"bk/getBankList.do"

//在线存款
#define kBankPay @"bk/BankPay.do"

//支付
#define kScanPay @"PlatformPay/scanPay"

//网银支付
#define kOnlineBanking @"PlatformPay/onlineBanking"

//退出登录
#define kLogout @"logout.do"

//发送验证码
#define kSendChangeCode @"Mobile/sendChangeCode.do"

//修改手机号码
#define kChangeMobile @"Mobile/changeMobile.do"

//支付渠道数据获取
#define kPaymentChannel @"PlatformPay/paymentChannel"

//手机号注册
#define kPhoneRegister @"Mobile/register.do"


/* h5 */

//会员中心
#define kH5MemberCentre @"appLoading?app=true&appTo=Membercenter&"
//存款
#define kH5Deposit @"appLoading?app=true&appTo=Lottery&"
//客服
#define kH5NoteSingle @"NoteSingle?app=true&appTo=NoteSingle"
//帮助
#define kH5Help @"help?app=true&appTo=help"
//关于
#define kH5CareAbout @"aboutOne?app=true&appTo=aboutOne"


//联系客服链接
#define kContactService @"https://www16.53kf.com/m.php?cid=72181525&arg=10181525&kf_sign=TQ4ODMTUzOY1MzEwMzY4ODg0NDIxMDE1&style=1"




#endif /* GAPI_h */
