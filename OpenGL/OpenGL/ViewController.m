//
//  ViewController.m
//  OpenGL
//
//  Created by 马家俊 on 17/5/17.
//  Copyright © 2017年 MJJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) EAGLContext* m_context;
@property(nonatomic,strong) GLKBaseEffect* m_baseEffect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView* view = (GLKView*)self.view;
    view.context = self.m_context;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.m_context];
    
    GLfloat squareVertextData[] =
    {
        0.5,-0.5,0.0f,      1.0f,0.0f,  //右下
        0.5,0.5,-0.0f,      1.0f,1.0f,  //右上
       -0.5f,0.5f,0.0f,     0.0f,1.0f,  //左上
        
        0.5,-0.5,0.0f,      1.0f,0.0f,  //右下
       -0.5f,0.5f,0.0f,     0.0f,1.0f,  //左上
       -0.5f,-0.5f,0.0f,    0.0f,0.0f   //左下
        
        
    };
    
    GLuint buffer;
    glGenBuffers(1, &buffer);   //glGenBuffers申请一个标识符
    glBindBuffer(GL_ARRAY_BUFFER, buffer);  //glBindBuffer把标识符绑定到GL_ARRAY_BUFFER上
    
    //glBufferData把顶点数据从cpu内存复制到gpu内存
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertextData), squareVertextData, GL_STATIC_DRAW);
    
    //glEnableVertexAttribArray 是开启对应的顶点属性
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    //glVertexAttribPointer设置合适的格式从buffer里面读取数据
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*5, (GLfloat*)NULL+0);
    
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*5, (GLfloat*)NULL+3);
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"IMG_2132" ofType:@"JPG"];
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1),GLKTextureLoaderOriginBottomLeft, nil];
    
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    
    self.m_baseEffect = [[GLKBaseEffect alloc]init];
    self.m_baseEffect.texture2d0.enabled = GL_TRUE;
    self.m_baseEffect.texture2d0.name = textureInfo.name;
    
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 *  渲染场景代码
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.m_baseEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
