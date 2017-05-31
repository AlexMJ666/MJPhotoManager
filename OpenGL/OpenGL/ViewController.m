//
//  ViewController.m
//  OpenGL
//
//  Created by 马家俊 on 17/5/17.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>
@interface ViewController ()
@property (nonatomic , strong) EAGLContext* mContext;
@property (nonatomic , strong) GLKBaseEffect* mEffect;
@property (nonatomic , assign) GLuint       myProgram;
@property (nonatomic , strong) IBOutlet UIImageView* imgView;
@property (nonatomic , strong) IBOutlet UISlider* sliderView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* img = [UIImage imageNamed:@"IMG_2132.JPG"];
    GPUImageContrastFilter *filter = [[GPUImageContrastFilter alloc] init];
    filter.contrast = self.sliderView.value;
    [filter forceProcessingAtSize:img.size];
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:img];
    [pic addTarget:filter];
    
    [pic processImage];
    [filter useNextFrameForImageCapture];
    self.imgView.image = [filter imageFromCurrentFramebuffer];
//    [self setupConfig];
  //  [self uploadVertexArray];
    //[self uploadTexture];
}

- (void)setupConfig {
    //新建OpenGLES 上下文
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]; //2.0，还有1.0和3.0
    GLKView* view = (GLKView *)self.view; //storyboard记得添加
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;  //颜色缓冲区格式
    [EAGLContext setCurrentContext:self.mContext];
}

- (void)uploadVertexArray {
    //顶点数据，前三个是顶点坐标，后面两个是纹理坐标
    GLfloat squareVertexData[] =
    {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    
    //顶点数据缓存
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
}

- (void)uploadTexture {
    //纹理贴图
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"IMG_2132" ofType:@"JPG"];
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    //着色器
    self.mEffect = [[GLKBaseEffect alloc] init];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = textureInfo.name;
}

/**
 *  渲染场景代码
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.mEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

    
//    GLuint rotate = glGetUniformLocation(self.myProgram, "rotateMatrix");
//    float radians = 10*3.14159f/180.0f;
//    float s = sin(radians);
//    float c = cos(radians);
//    
//    //z轴旋转矩阵
//    GLfloat zRotation[16] = { //
//        c,      -s,     0,      0.2, //
//        s,      c,      0,      0,//
//        0,      0,      1.0,    0,//
//        0.0,    0,      0,      1.0//
//    };
//    glUniformMatrix4fv(rotate, 1, GL_FALSE, (GLfloat *)&zRotation[0]);
//    
//    glDrawArrays(GL_TRIANGLES, 0, 6);
//    [self.m_context presentRenderbuffer:GL_RENDERBUFFER];
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
