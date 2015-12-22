//
//  BoardViewController.m
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import "BoardViewController.h"


@interface BoardViewController ()
@property (nonatomic,weak) CanvasViewController *CanvasRef;
@end

@implementation BoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedFiguresPanel"])
    {
        PanelFiguresViewController * temp = segue.destinationViewController;
        temp.canvasDelegate = self.CanvasRef;
    }
    if ([segue.identifier isEqualToString:@"embedColorsPanel"])
    {
        PanelColorsViewController * temp = segue.destinationViewController;
        temp.canvasDelegate = self.CanvasRef;
    }
    if ([segue.identifier isEqualToString:@"embedCanvas"])
    {
        self.CanvasRef = segue.destinationViewController;
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
