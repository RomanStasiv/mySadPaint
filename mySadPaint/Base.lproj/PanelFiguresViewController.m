//
//  PanelFiguresViewController.m
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import "PanelFiguresViewController.h"

@interface PanelFiguresViewController ()
@property (nonatomic, strong) NSString *selectedFigure;
@end

@implementation PanelFiguresViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedFigure = @"line";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getSelectedFigureName
{
    return self.selectedFigure;
}
- (IBAction)selectedIndexChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0: [self.canvasDelegate setFigureType:@"line"];
            break;
        case 1: [self.canvasDelegate setFigureType:@"rect"];
            break;
        case 2: [self.canvasDelegate setFigureType:@"triangle"];
            break;
        case 3: [self.canvasDelegate setFigureType:@"ellipse"];
            break;
        case 4: [self.canvasDelegate setFigureType:@"sadness"];
            break;
        case 5: [self.canvasDelegate setFigureType:@"image"];
            break;
        case 6: [self.canvasDelegate setFigureType:@"pencil"];
            break;
    }
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
