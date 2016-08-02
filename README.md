# HDRequestManager
##pod "HDRequestManager"
##Base on AFNetworking 3
##First Step

```objectivec
#import "HDRequestManager/HDRequestConfig.h" 
```

##Second Step
```objectivec
//Init
HDApiConfigure *apiConfigure = [[HDApiConfigure alloc] init];
//Request Method 
apiConfigure.requestMethod = HDREQUEST_METHOD_GET;
//Request URL
apiConfigure.url = @"https://www.google.com.hk/";
//Response Block
apiConfigure.afterRequest = ^(id responseData){

	// process the response data 

};
//Save The ApiConfigure
[HDApiManager addConfigure:apiConfigure withApiKey:@"demoApi"];

```

##Third Step
```objectivec

//Add Request Parameters
NSDictionary *param = @{@"username":@"HundredLee",@"password":@"123456"};

//Load The ApiConfigure
HDApiManager *apiManager = [HDApiManager createApiConfigure:@"demoApi"];

//Submit The Request Parameters
[apiManager requestWithParams:param];

```


