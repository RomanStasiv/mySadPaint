//
//  PanelFiguresViewController.m
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import "PanelFiguresViewController.h"

@interface PanelFiguresViewController ()
@property (nonatomic, weak) UIButton *selectedFigureButton;
@end

@implementation PanelFiguresViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectedFigureChanged:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 100: [self.canvasDelegate setFigureType:@"line"];
            break;
        case 101: [self.canvasDelegate setFigureType:@"rect"];
            break;
        case 102: [self.canvasDelegate setFigureType:@"triangle"];
            break;
        case 103: [self.canvasDelegate setFigureType:@"ellipse"];
            break;
        case 104: [self.canvasDelegate setFigureType:@"sadness"];
            break;
        case 105: [self.canvasDelegate setFigureType:@"image"];
            break;
        case 106: [self.canvasDelegate setFigureType:@"pencil"];
            break;
    }
    sender.backgroundColor = [UIColor grayColor];
    self.selectedFigureButton.backgroundColor = [UIColor clearColor];
    self.selectedFigureButton = sender;
}

- (IBAction)cancelPressed
{
    [self.canvasDelegate cancelLastFigure];
}
- (IBAction)savePressed
{
    [self.canvasDelegate saveToFile];
}
- (IBAction)loadPressed
{
    [self.canvasDelegate readFromFile];
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
