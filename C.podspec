
Pod::Spec.new do |s|
s.name = "C"
s.version = "0.0.2"
s.summary = "Just for test"
s.description = <<-DESC
                This is a demo
                Just For test 
                私有库创建联系
                DESC
s.homepage         = "https://github.com/XiMingJun/C"                           #主页,这里要填写可以访问到的地址，不然验证不通过
s.license = { :type => "MIT", :file => "FILE_LICENSE" }
s.author= { "wangjian" => "wangjian@qhfax.com.cn" }                   #作者信息
s.source= { :git => "https://github.com/XiMingJun/C.git", :tag => s.version }      #项目地址，这里不支持ssh的地址，验证不通过，只支持HTTP和HTTPS，最好使用HTTPS
s.platform= :ios, '7.0'#支持的平台及版本
s.requires_arc=true#是否使用ARC，如果指定具体文件，则具体的问题使用ARC
s.source_files = "C/C/**/*.{h,m}"
end
