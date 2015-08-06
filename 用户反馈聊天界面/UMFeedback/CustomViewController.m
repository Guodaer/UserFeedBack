//
//  CustomViewController.m
//  UMFeedback
//
//  Created by 郭达 on 15/5/7.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import "CustomViewController.h"
#import "UMFeedback.h"
#import "CustomCell.h"
#import "customModel.h"
#import "UIView+GDQuickcontrol.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface CustomViewController ()<UMFeedbackDataDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    //输入区域
    UIView *_inputArea;
    UITextField *_textField;
    //存储图片
    NSData *_imageData;
    
}
@property (strong, nonatomic) UMFeedback *feedback;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation CustomViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    returnBtn.frame = CGRectMake(0, 30, 40, 30);
    [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:returnBtn];
    [returnBtn addTarget:self action:@selector(returnBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self customOfMyself];
    [self createInputArea];
}
#pragma mark - 添加输入区域
-(void)createInputArea
{
    _inputArea = [[UIView alloc] initWithFrame:CGRectMake(0,HEIGHT - 44, WIDTH, 44)];
    [self.view addSubview:_inputArea];
    //添加背景图
    UIImageView *backView = [[UIImageView alloc] initWithFrame:_inputArea.bounds];
    backView.image = [UIImage imageNamed:@"toolbar_bottom_bar.png"];
    [_inputArea addSubview:backView];
    //录音按钮
    UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:nil message:@"暂不支持语音输入,请等待下一版本" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    __block UIAlertView *alert1 = alertView;
    [_inputArea addImageButtonWithFrame:CGRectMake(4, 4, 36, 36) title:nil backgroud:@"chat_bottom_voice_nor.png" action:^(UIButton *button) {
//        [_textField becomeFirstResponder];
        
        [alert1 show];
        
    }];
    //+添加图片
    
    [_inputArea addImageButtonWithFrame:CGRectMake(WIDTH-40, 4, 36, 36) title:nil backgroud:@"chat_bottom_up_nor.png" action:^(UIButton *button) {

        UIImagePickerController * pic = [[UIImagePickerController alloc] init];
        pic.delegate = self;
        pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pic.allowsEditing = YES;
        [self presentViewController:pic animated:YES completion:nil];
    
        
    }];
    //输入框背景图
    [_inputArea addImageViewWithFrame:CGRectMake(44, 4, WIDTH-44-80+36, 36) image:@"chat_bottom_textfield.png"];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(46, 4, WIDTH-44-80-4-4+36, 36)];
    [_inputArea addSubview:_textField];
    _textField.delegate = self;
    
    
    //添加键盘事件处理
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealHider:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}
#pragma mark - UIImagePickerController的代理
// 图片完成选取
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSLog(@"iamge = %@",image);
    //
     _imageData = UIImageJPEGRepresentation(image, 1.0f);
    
    //    NSData *imageData = UIImagePNGRepresentation(image);
    
//    NSLog(@"imageData  %@",_imageData);
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [[UMFeedback sharedInstance] post:@{UMFeedbackMediaTypeImage: _imageData}];

    
}
//图片取消操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -输入区域上移，tableView高度缩小
-(void)dealShow:(NSNotification *)n
{
    //获取弹出后的位置
    NSValue *frameValue = n.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect endFrame;
    [frameValue getValue:&endFrame];
    
    //弹出时间
    NSValue *durationValue = n.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"];
    double duration;
    [durationValue getValue:&duration];
    
    //键盘上移
    [UIView animateWithDuration:duration animations:^{
        
        _inputArea.frame = CGRectMake(0, HEIGHT-endFrame.size.height-44,WIDTH, 44) ;
        
        //修改tableView高度
        _tableView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-44-endFrame.size.height-64);
        
        
        
    }];
    //        //表格试图滚动到最后一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}
-(void)dealHider:(NSNotification *)n
{
    //获取弹出后的位置
    NSValue *frameValue = n.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect endFrame;
    [frameValue getValue:&endFrame];
    
    //弹出时间
    NSValue *durationValue = n.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"];
    double duration;
    [durationValue getValue:&duration];
    
    //键盘下移
    [UIView animateWithDuration:duration animations:^{
        
        _inputArea.frame = CGRectMake(0, HEIGHT-44, WIDTH, 44) ;
        
        //修改tableView高度
        _tableView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-44-64);
        
    }];
    
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (![textField.text isEqualToString:@""]) {
    //输入的文本要显示到tableview中
    customModel *model = [[customModel alloc] init];
    
    model.content = textField.text;

    model.type = @"user_reply";//表示自己发送的
    [_dataArray addObject:model];
    
        
    //------post上传------
        NSDictionary *postContent = @{@"content":textField.text,
                                      @"gender":@"1",
                                      @"age_group":@"3",
                                      @"type":@"user_reply"};
        [[UMFeedback sharedInstance] post:postContent];

        
        
    //重新载入数据
    
    [_tableView reloadData];
    }
    [_textField resignFirstResponder];
    
    //发送完未空
    _textField.text = @"";
    return YES;
}


#pragma mark - return
-(void)returnBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)customOfMyself
{

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
        self.feedback = [UMFeedback sharedInstance];
    self.feedback.delegate = self;
    [self.feedback get];

}

#pragma mark - UMFeedback Delegate
- (void)getFinishedWithError:(NSError *)error {
//    NSLog(@"111111111%s", __func__);
    if (error != nil) {
        NSLog(@"2222222%@", error);
    } else {
        NSLog(@"333333%@", self.feedback.topicAndReplies);
        //获取数据
        for (NSDictionary *dic in self.feedback.topicAndReplies) {
            customModel *model = [[customModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        //显示聊天记录的最后一行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)postFinishedWithError:(NSError *)error {
    NSLog(@"4444444%s", __func__);
    if (error != nil) {
        NSLog(@"5555555   %@", error);
    } else {
        NSLog(@"6666666%@", self.feedback.topicAndReplies);
        
        
        
        
    }
}
#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取文本占用区域
    //计算文本占据的高度
    customModel *model = _dataArray[indexPath.row];
    CGRect contentRect = [model.content boundingRectWithSize:CGSizeMake(165, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    //
    double height = 5 + ( 5 + contentRect.size.height + 12) + 10;
    
    
    return height<(5 + 45 + 5)?54:height;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    customModel *model = _dataArray[indexPath.row];
    cell.created_atLabel.text = [NSString stringWithFormat:@"%@",model.created_at];
    
//    if ((NSNull *)model.content != [NSNull null]) {
//        cell.contentLabel.text = [NSString stringWithFormat:@"%@",model.content];
//    }
//    else{
//            cell.audioImg.image = [UIImage imageNamed:@"bubble_min@2x.png"];
//
//        NSLog(@"我是空的");
//        
//    }
    cell.headImageView.image = [UIImage imageNamed:@"icon01.png"];
    cell.MessageImageView.image = [[UIImage imageNamed:@"chatfrom_bg_normal.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:0];

    cell.contentLabel.text = model.content;
    [cell adjustSizeWithType:[NSString stringWithFormat:@"%@",model.type]];

    
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//用字典生成model的代码
-(void)createModelCodeWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
{
    printf("\n@interface %s : NSObject\n",modelName.UTF8String);
    for (NSString *key in dict) {
        printf("@property (copy,nonatomic) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
