//
//  DesignViewerViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "DesignViewerViewController.h"

@interface DesignViewerViewController ()

@property (weak, nonatomic) IBOutlet SCNView * sceneView;

/** A SCNScene which serves as the container for the node hierarchy. */
@property (strong, nonatomic, nonnull) SCNScene * scene;

/** A SCNNode which represents the camera used to provide a point of view for displaying the scene. */
@property (strong, nonatomic, nonnull) SCNNode * cameraNode;

/** @brief Configures the SCNScene  instance which serves as the container for the node hierarchy. */
- (void)configureScene;

/** @brief Configures the camera used to provide a point of view for displaying the scene. */
- (void)configureCamera;

@end

@implementation DesignViewerViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        _scene =[SCNScene sceneNamed:@"art.scnassets/mars-rover"];
        _cameraNode = [SCNNode node];
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureScene];
    [self configureCamera];
}

#pragma mark - Methods

- (void)configureScene
{
    [self.sceneView setScene:self.scene];
    [self.sceneView setShowsStatistics:YES];
}

- (void)configureCamera
{
    SCNCamera * camera = [SCNCamera camera];
    
    // Assign the created SCNCamera instance to the camera node's camera property.
    [self.cameraNode setCamera:camera];
    
    // Set the camera's position.
    SCNVector3 cameraPosition = { 0, 0, 10 };
    [self.cameraNode setPosition:cameraPosition];
    
    // Add the camera node to the scene.
    [self.scene.rootNode addChildNode:self.cameraNode];
}

- (IBAction)doneBarButtonItemTaped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
