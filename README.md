# categoryDemo
这是一个categoryDemo的探究,辅助blog的Demo:https://blog.csdn.net/appleLg/article/details/79931742
# 主类和分类
时间有限,可以直接看结论,或者联系我企鹅qq:549931192
## 一. 需要解决的问题
1. 主类和分类中普通方法的调用顺序?
2. 同一个主类的两个分类中的同名方法调用顺序?
3. 分类中+load方法的调用顺序?
4. 分类中+initialize 方法的调用顺序?
## 二. 测试环境搭建
1. 创建下面这些测试用的类
![这里写图片描述](https://img-blog.csdn.net/20180413130611290?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FwcGxlTGc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
2. 加入一个pch文件方便打印

```
#ifdef DEBUG
#define LGLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#define LGLog(...)
#endif

```
## 主要内容
### 1. 主类,子类和分类中的+load方法的加载
- 我们在主类和各分类中重写+load方法

```
//Person
+ (void)load{
LGLog();
}
//-------------
//Son
+ (void)load{
LGLog();
}
//-------------
Person+A
+ (void)load{
LGLog();
}
//-------------
Person+B
+ (void)load{
LGLog();
}
//-------------
Person+C
+ (void)load{
LGLog();
}
```
- 打印输出
![这里写图片描述](https://img-blog.csdn.net/20180413160525884?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FwcGxlTGc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
- 调整分类的编译顺序在打印
![这里写图片描述](https://img-blog.csdn.net/2018041316063054?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FwcGxlTGc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

### 2. 结论
* +load方法的调用是在main() 函数之前,并且不需要主动调用,就是说程序启动会把所有的文件加载
* 主类和分类的都会加载调用+load方法
* 主类与分类的加载顺序是:主类优先于分类加载,无关编译顺序
*  分类间的加载顺序取决于编译的顺序:编译在前则先加载,编译在后则后加载
* 规则是父类优先于子类, 子类优先于分类(父类>子类>分类)
### 1. 探究主类和分类的普通同名方法调用顺序
* 我们在主类中加入普通的类方法(+commonClsMethod)和实例方法(-commonInstanceMethod)
* 在分类中也重写这两个方法

```
+ (void)commonClsMethod{
LGLog();
}
- (void)commonInstanceMethod{
LGLog();
}
```
1. 正常结果
![这里写图片描述](https://img-blog.csdn.net/20180413161614936?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FwcGxlTGc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
2. 分类文件警告
![这里写图片描述](https://img-blog.csdn.net/20180413162147203?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FwcGxlTGc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
### 结论
* 普通的方法中, 分类同名方法会覆盖主类的方法
* 多个分类中的同名方法会只执行一个,即后编译的分类里面的方法会覆盖所有前面的同名方法(可以通过调换编译顺序来获得这个结论)
* 分类中的方法名和主类方法名一样会报警告,大概就是说分类中实现的方法主类已经实现了
* 可以把声明写在主类, 实现写在分类,这样也能调用到分类里面的代码
* 同样可以把声明和实现写在不同的分类文件中,还是能找到的, 不过主类要相同
### 探究+ initialize方法的调用
* 调用子类的+ (void)initialize方法

```
[[Son new] commonInstanceMethod];
```


![这里写图片描述](https://img-blog.csdn.net/20180413164430125?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FwcGxlTGc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
### 结论
* 当第一次用到类的时候, 如果重写了+ initialize方法,会去调用
* 当调用子类的+ initialize方法时候, 先调用父类的,如果父类有分类, 那么分类的+ initialize会覆盖掉父类的, 和普通方法差不多
* 父类的+ initialize不一定会调用, 因为分类可能重写了它
* 普通方法的优先级:分类>子类>父类
## 总结
1. 普通方法的优先级: 分类> 子类 > 父类, 优先级高的同名方法覆盖优先级低的
2. +load方法的优先级: 父类> 子类> 分类
3. +load方法是在main() 函数之前调用,所有的类文件都会加载,包括分类
4. +load方法不会被覆盖
5. 同一主类的不同分类中的普通同名方法调用, 取决于编译的顺序, 后编译的文件中的同名方法会覆盖前面所有的,包括主类. +load方法的顺序也取决于编译顺序, 但是不会覆盖
6. 分类中的方法名和主类方法名一样会报警告, 不会报错
7. 声明和实现可以写在不同的分类中, 依然能找到实现
8. 当第一次用到类的时候, 如果重写了+ initialize方法,会去调用
9. 当调用子类的+ initialize方法时候, 先调用父类的,如果父类有分类, 那么分类的+ initialize会覆盖掉父类的, 和普通方法差不多
10. 父类的+ initialize不一定会调用, 因为有可能父类的分类重写了它
#### demo
* https://github.com/LGLee/categoryDemo
* 下载下来通过注释或者其他的方式可以验证或者添加其他的方法验证,这只是一个简单的探究
