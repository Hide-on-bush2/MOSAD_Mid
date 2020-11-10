# 使用Mock造假数据

## 使用方法

cd 到 server文件夹下，执行以下命令安装依赖包：

```
npm install
```

然后执行以下命令启动服务器：

```
npm start
```

## 造假后端

我们可以使用mock来造假数据，也就是我们发起一个GET/POST请求的时候，可以返回一些填充的数据，等到有真正的后端的时候才实现具体的逻辑

### Demo

我们在app.js中增加以下代码：

```
var Mock = require('mockjs')
var data = Mock.mock({
    // 属性 list 的值是一个数组，其中含有 1 到 10 个元素
    'list|1-10': [{
        // 属性 id 是一个自增数，起始值为 1，每次增 1
        'id|+1': 1
    }]
})

app.get('/helloworld', function (req, res) {
  res.send(data)
})
```
简单来说就是用`Mock.mock`来创建数据，然后在`app.get()`中将这个数据返回

可以打开`localhost:3000/helloworld`看到返回的数据

## 与IOS程序交互

可以在`main.m`中写一些简单的测试代码：

```
// 1.请求路径
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/helloworld"];
    // 2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3.创建 session 对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.普通任务 - get
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse * response, NSError *error) {
        if (error) {
            NSLog(@"NSURLSessionDataTaskerror:%@",error);
            return;
        }
        
        //5.解析数据
        NSLog(@"NSURLSessionDataTask:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    // 启动任务
    [dataTask resume];
```

然后运行（在这之前记得先把服务端运行起来），可以得到下面结果：

![](https://tva1.sinaimg.cn/large/0081Kckwgy1gkka9pvboyj30oq05uq4h.jpg)

### 可能会遇到的问题

如果运行IOS程序出现错误The resource could not be loaded because the App Transport Security policy requires the use of a secure connection，可以参考以下[博客](https://www.jianshu.com/p/3eac2d8810e9)