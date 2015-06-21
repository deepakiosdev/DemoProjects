//
//  ViewController.m
//  Demo
//
//  Created by Deepak on 17/04/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "ViewController.h"
#import "GrowingCell.h"

@interface ViewController ()
{
    float cellHieght;
    int numOfLinesInTextView;
    int margin; //Remaining cell space expect textview
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrTableHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
  
    numOfLinesInTextView = 1;
    [super viewDidLoad];
   
    
    cellHieght = 44;
    [self.tblView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    margin = cellHieght - [self.view viewWithTag:100].frame.size.height;
    [[self.view viewWithTag:100] becomeFirstResponder];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
       CGRect textFrame        = textView.frame;
        textFrame.size.height   = textView.contentSize.height;
        textView.frame          = textFrame;
    
//        [UIView animateWithDuration:0.1 animations:^{
//            [textView invalidateIntrinsicContentSize];
//        }];

    int numLines = textView.contentSize.height / textView.font.lineHeight;
    cellHieght = textView.contentSize.height + margin;
    NSLog(@"Curent numLines:%d \n Prev No of Line:%d, \n cellHieght:%f ",numLines,numOfLinesInTextView,cellHieght);
    

    if (numLines != numOfLinesInTextView)
    {
        [textView sizeToFit];
        numOfLinesInTextView = numLines;
        self.constrTableHeight.constant = cellHieght + 10;
        [self.tblView reloadData];
        [self performSelector:@selector(showkeyboard) withObject:nil afterDelay:.05];

    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"GrowingCell";
    
    GrowingCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[GrowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAX(cellHieght, 44);
}

-(void)showkeyboard
{
    [[self.view viewWithTag:100] becomeFirstResponder];
}
@end
