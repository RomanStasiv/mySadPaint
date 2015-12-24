//
//  PanelColorsViewController.m
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import "PanelColorsViewController.h"

@interface PanelColorsViewController ()
@property (nonatomic,strong) UIColor *selectedColor;
@property (weak, nonatomic) IBOutlet UILabel *curentColorLabel;
@end

@implementation PanelColorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectedColorChanged:(UIButton *)sender
{
    self.curentColorLabel.backgroundColor = sender.backgroundColor;
    self.selectedColor = sender.backgroundColor;
    [self.canvasDelegate setColor:self.selectedColor ];
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
