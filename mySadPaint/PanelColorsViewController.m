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


- (UIColor *)getSelectedColor
{
    return _selectedColor;
}

- (IBAction)selectedIndexChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0: [self.canvasDelegate setColor:[UIColor redColor]];
            break;
        case 1: [self.canvasDelegate setColor:[UIColor greenColor]];
            break;
        case 2: [self.canvasDelegate setColor:[UIColor blueColor]];
            break;
    }
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
